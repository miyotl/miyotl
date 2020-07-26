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

class Variant {
  final String word;
  final String sourceId;

  const Variant({this.word, this.sourceId});
}

class DictionaryEntry {
  final String sourceId;
  final String originalWord;
  final String translatedWord;
  final String partOfSpeech;
  final String category;
  final String originalExample; // TODO: hacer un enum o una clase?
  final String translatedExample;
  final String ipa;
  final List<Variant> variants;

  /// Número máximo de variantes que puede haber.
  /// Es una limitación por la forma en que está estructurado
  /// Google Sheets
  static const max_variants = 4;

  const DictionaryEntry({
    this.sourceId,
    this.originalWord,
    this.translatedWord,
    this.partOfSpeech,
    this.category,
    this.originalExample,
    this.translatedExample,
    this.ipa,
    this.variants,
  });

  factory DictionaryEntry.fromJson(dynamic json) {
    final List<Variant> variants = [];

    for (int i = 1; i <= max_variants; i++) {
      if (json['var$i'] != null) {
        variants.add(Variant(
          word: json['var$i'],
          sourceId: json['source$i'],
        ));
      }
    }

    return DictionaryEntry(
      sourceId: json['source'],
      originalWord: json['word'] ?? 'En blanco',
      translatedWord: json['translation'] ?? 'En blanco',
      ipa: json['ipa'],
      originalExample: json['example'],
      translatedExample: json['example_translated'],
      partOfSpeech: json['grammatical_category'],
      category: json['category'],
      variants: variants,
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
    return entries
        .where((entry) =>
            entry.originalWord.toLowerCase().contains(query) ||
            entry.translatedWord.toLowerCase().contains(query))
        .toList();
  }
}
