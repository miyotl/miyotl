import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'constants.dart';
import 'dictionary.dart';

export 'dictionary.dart';
export 'constants.dart';

String capitalize(String string) {
  return '${string[0].toUpperCase()}${string.substring(1)}';
}

class AppState extends ChangeNotifier {
  /// Current language for dictionary, learning and culture
  String language = 'Tzotzil';

  /// The mode to sort and lookup words
  LookupMode lookupMode = LookupMode.spanishToLanguage;

  /// Whether the data is loading, to make the app show it's loading
  bool loading = true;

  /// The decoded JSON information
  Map<String, dynamic> data;

  /// The sources of information (author, location, etc)
  Sources sources;

  /// All dictionaries for all languages
  /// TODO: only the current language(s) should be downloaded
  Map<String, Dictionary> dictionaries;

  /// The dictionary for the current language
  Dictionary get dictionary => dictionaries[language];

  /// The name of the current language, where the first letter is a capital
  String get languageName => capitalize(language);

  /// Favorite words
  List<DictionaryEntry> favorites;

  AppState() {
    getData();
  }

  void changeLanguage(String other) {
    language = other;
    notifyListeners();
  }

  void changeLookupMode(LookupMode _lookupMode) {
    lookupMode = _lookupMode;
    dictionary.sort(_lookupMode);
    notifyListeners();
  }

  void getData() async {
    loading = true;
    notifyListeners();
    var response = await get(dictionary_url);
    // Interpretar el archivo como UTF-8, o si no los caracteres especiales como acentos
    // no se decodifican correctamente
    // TODO: implement some exception handling
    data = json.decode(utf8.decode(response.bodyBytes));
    sources = Sources.fromJson(data['Referencias']);
    dictionaries = {};
    for (var entry in data.entries) {
      // ignore sources, as they are combined in the same JSON
      if (entry.key == 'Referencias' || entry.key == 'Gramática') {
        continue;
      }
      dictionaries[entry.key] = Dictionary.fromJson(entry.value);
    }
    dictionary.sort(lookupMode);
    loading = false;
    notifyListeners();
  }
}
