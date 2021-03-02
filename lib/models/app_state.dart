import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import 'dictionary.dart';
import 'culture.dart';
import 'language.dart';

export 'dictionary.dart';
export 'constants.dart';
export 'culture.dart';
export 'language.dart';

String capitalize(String string) {
  return '${string[0].toUpperCase()}${string.substring(1)}';
}

class AppState extends ChangeNotifier {
  UserCredential firebaseCredential;

  Future<bool> get hasFinishedOnboarding async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool('hasFinishedOnboarding') ?? false;
  }

  Future<void> setOnboardingStatus(bool hasFinishedOnboarding) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('hasFinishedOnboarding', hasFinishedOnboarding);
  }

  Future<String> getDefaultLanguage() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString('language');
  }

  Future<void> setDefaultLanguage(String language) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('language', language);
  }

  Future<String> get givenName async {
    var isLogged = await FacebookAuth.instance.isLogged;
    if (isLogged == null) {
      return FirebaseAuth.instance?.currentUser?.displayName ??
          'Ajolote anónimo';
    } else {
      var userData = await FacebookAuth.instance.getUserData();
      return userData['name'] ?? '<error al obtener tu nombre>';
    }
  }

  /// Current language for dictionary, learning and culture
  String language = 'Mazateco';

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

  /// Cultures for each language
  Map<String, List<CultureEntry>> cultures = {};

  /// The culture for the current language
  List<CultureEntry> get culture => cultures[language];

  /// The dictionary for the current language
  Dictionary get dictionary => dictionaries[language];

  /// The name of the current language, where the first letter is a capital
  String get languageName => capitalize(language);

  /// Favorite words
  List<DictionaryEntry> favorites;

  /// List of languages
  List<Language> languages = [];

  AppState() {
    getLanguageDataFromInternet();
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

  Future<bool> loadPrefs() async {
    language = await getDefaultLanguage() ?? 'Mazateco';
    return true;
  }

  /// Load language data (decoded from JSON)
  void loadLanguageData(Map<String, dynamic> data) {
    // TODO: implement some exception handling
    sources = Sources.fromJson(data['Referencias']);
    for (var language in data['Idiomas']) {
      languages.add(Language.fromJson(language));
    }
    dictionaries = {};
    for (var entry in data.entries) {
      // ignore sources, as they are combined in the same JSON
      if (entry.key == 'Referencias' ||
          entry.key == 'Gramática' ||
          entry.key == 'Idiomas' ||
          entry.key == 'Cultura') {
        continue;
      }
      cultures[entry.key] = [];
      dictionaries[entry.key] = Dictionary.fromJson(entry.value);
    }
    for (Map<String, dynamic> cultureJson in data['Cultura']) {
      cultures[cultureJson['language']].add(CultureEntry.fromJson(cultureJson));
    }
    dictionary.sort(lookupMode);
  }

  /// Get language data from the internet
  void getLanguageDataFromInternet() async {
    loading = true;
    notifyListeners();
    var response = await get(dictionary_url);

    /// Interpret the response as UTF-8 so special characters can be rendered properly
    data = json.decode(utf8.decode(response.bodyBytes));
    loadLanguageData(data);
    loading = false;
    notifyListeners();
  }

  /// Update language data from the internet, if an update is available
  void updateLanguageData() {
    getLanguageDataFromInternet();
  }
}
