// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import 'dictionary.dart';
import 'culture.dart';
import 'language.dart';

export 'dictionary.dart';
export 'constants.dart';
export 'culture.dart';
export 'language.dart';
export 'user_account.dart';

String capitalize(String string) {
  return '${string[0].toUpperCase()}${string.substring(1)}';
}

class AppState extends ChangeNotifier {
  Future<bool> get hasFinishedOnboarding async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool('hasFinishedOnboarding') ?? false;
  }

  Future<void> setOnboardingStatus(bool hasFinishedOnboarding) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('hasFinishedOnboarding', hasFinishedOnboarding);
  }

  Future<String?> getDefaultLanguage() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString('language');
  }

  Future<void> setDefaultLanguage(String language) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('language', language);
  }

  /// Current language for dictionary, learning and culture
  String language = 'Mazateco';

  /// The mode to sort and lookup words
  LookupMode lookupMode = LookupMode.spanishToLanguage;

  /// Whether the data is loading, to make the app show it's loading
  bool loading = true;

  /// The decoded JSON information
  late Map<String, dynamic> data;

  /// The sources of information (author, location, etc)
  late Sources sources;

  /// All dictionaries for all languages
  /// TODO: only the current language(s) should be downloaded
  late Map<String, Dictionary> dictionaries;

  /// Cultures for each language
  Map<String, List<CultureEntry>> cultures = {};

  /// The culture for the current language
  List<CultureEntry>? get culture => cultures[language];

  /// The dictionary for the current language
  Dictionary? get dictionary => dictionaries[language];

  /// The name of the current language, where the first letter is a capital
  String get languageName => capitalize(language);

  /// Favorite words
  late List<DictionaryEntry> favorites;

  /// List of languages
  List<Language> languages = [];

  Future<String> get lastUpdate async {
    String intToDateStr(int n) {
      final String _string = n.toString();
      return '${_string.substring(6, 8)}/${meses[int.parse(_string.substring(4, 6)) - 1]}/${_string.substring(0, 4)} (${int.parse(_string.substring(8, 10))})';
    }

    final prefs = await SharedPreferences.getInstance();
    int? lastUpdate = prefs.getInt('last-update');
    if (lastUpdate == null) {
      return 'Nunca';
    } else {
      return intToDateStr(lastUpdate);
    }
  }

  AppState() {
    init();
  }

  Future<void> init() async {
    loading = true;
    notifyListeners();
    await loadLanguageData();
    loading = false;
    notifyListeners();
  }

  void changeLanguage(String other) {
    language = other;
    notifyListeners();
  }

  void changeLookupMode(LookupMode _lookupMode) {
    lookupMode = _lookupMode;
    dictionary?.sort(_lookupMode);
    notifyListeners();
  }

  Future<bool> loadPrefs() async {
    language = (await getDefaultLanguage())!;
    return true;
  }

  Future<void> loadLanguageData() async {
    String dataString = await loadLanguageDataFromDisk();
    loadLanguageDataFromJson(json.decode(dataString));
    loading = false;
    notifyListeners();
    await updateLanguageData();
  }

  /// Load language data (decoded from JSON)
  void loadLanguageDataFromJson(Map<String, dynamic> _data) {
    // TODO: implement some exception handling
    data = _data;
    sources = Sources.fromJson(data['Referencias']);
    languages = [];
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
      cultures[cultureJson['language']]?.add(CultureEntry.fromJson(cultureJson));
    }
    dictionary?.sort(lookupMode);
    notifyListeners();
  }

  /// Get language data from the internet
  Future<void> getLanguageDataFromInternet() async {
    var response = await get(Uri.parse(dictionary_url));

    /// Interpret the response as UTF-8 so special characters can be rendered properly
    var dataString = utf8.decode(response.bodyBytes);
    data = json.decode(dataString);
    loadLanguageDataFromJson(data);
    _saveLanguageDataToDisk(dataString);
  }

  /// Update language data from the internet, if an update is available
  Future<void> updateLanguageData() async {
    final prefs = await SharedPreferences.getInstance();
    int currentVersion = prefs.getInt('last-update') ?? 0;
    var response = await get(Uri.parse(last_update_url));
    int latestVersion = int.parse(response.body);
    if (latestVersion > currentVersion) {
      await getLanguageDataFromInternet();
      prefs.setInt('last-update', latestVersion);
      notifyListeners();
    }
  }

  Future<File> _getLanguageFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/data.json');
  }

  Future<void> _saveLanguageDataToDisk(String data) async {
    final file = await _getLanguageFile();
    await file.writeAsString(data);
  }

  Future<String> loadLanguageDataFromDisk() async {
    try {
      final file = await _getLanguageFile();
      return await file.readAsString();
    } catch (e) {
      return await rootBundle.loadString('img/data.json');
    }
  }
}
