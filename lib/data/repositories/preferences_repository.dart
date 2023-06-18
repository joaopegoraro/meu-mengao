import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencesRepository {
  Future<bool> setDarkMode(bool isDarkMode);
  Future<bool> getDarkMode();
}

class PreferencesRepositoryImpl extends PreferencesRepository {
  @override
  Future<bool> setDarkMode(bool isDarkMode) async {
    final prefs = await _getPrefs();
    return await prefs.setBool(_darkModeKey, isDarkMode);
  }

  @override
  Future<bool> getDarkMode() async {
    final prefs = await _getPrefs();
    return prefs.getBool(_darkModeKey) ?? false;
  }

  Future<SharedPreferences> _getPrefs() async => await SharedPreferences.getInstance();

  static const _darkModeKey = "DARK_MODE";
}

final preferencesRepositoryProvider = Provider<PreferencesRepository>((ref) {
  return PreferencesRepositoryImpl();
});
