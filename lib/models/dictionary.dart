enum LookupMode { languageToSpanish, spanishToLanguage }

class Source {
  String id;
  String author;
  String name;
  String region;

  Source._(this.id, this.author, this.name, this.region);

  factory Source.fromJson(dynamic json) {
    return Source._(json['id'], json['author'], json['source'], json['region']);
  }
}

class Sources {
  Map<String, Source> _sources = {};

  Sources.fromJson(List<dynamic> json) {
    for (var sourceJson in json) {
      var source = Source.fromJson(sourceJson);
      _sources[source.id] = source;
    }
  }

  Source getSource(String id) => _sources[id];
}

class DictionaryEntry {
  String sourceId;
  String originalWord;
  String translatedWord;

  DictionaryEntry({this.sourceId, this.originalWord, this.translatedWord});

  factory DictionaryEntry.fromJson(dynamic json) {
    return DictionaryEntry(
      sourceId: json['source'],
      originalWord: json['word'],
      translatedWord: json['translation'],
    );
  }
}

typedef Comparer<T> = int Function(T a, T b);

class Dictionary {
  List<DictionaryEntry> entries = [];

  Dictionary.fromJson(List<dynamic> json) {
    entries = json.map((entry) => DictionaryEntry.fromJson(entry)).toList();
  }

  Comparer<DictionaryEntry> _getComparisonFunction(LookupMode mode) {
    Comparer<DictionaryEntry> ans;
    switch (mode) {
      case LookupMode.languageToSpanish:
        ans = (a, b) => a.originalWord.compareTo(b.originalWord);
        break;
      case LookupMode.spanishToLanguage:
        ans = (a, b) => a.translatedWord.compareTo(b.translatedWord);
        break;
    }
    return ans;
  }

  void sort(LookupMode mode) {
    entries.sort(_getComparisonFunction(mode));
  }

  // TODO: improve efficiency
  List<DictionaryEntry> search(String query) {
    query = query.toLowerCase();
    return entries.where((entry) => entry.originalWord.toLowerCase().contains(query) || entry.translatedWord.toLowerCase().contains(query)).toList();
  }
}
