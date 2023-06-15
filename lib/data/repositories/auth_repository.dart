import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  Future<bool> saveToken(String token) async {
    final prefs = await _getPrefs();
    return await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await _getPrefs();
    return prefs.getString(_tokenKey);
  }

  Future<SharedPreferences> _getPrefs() async => await SharedPreferences.getInstance();

  static const _tokenKey = "TOKEN";
}
