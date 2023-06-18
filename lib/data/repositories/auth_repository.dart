import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRepository {
  Future<String?> signInAnonymously();

  Future<bool> saveToken(String token);

  Future<String?> getToken();
}

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<String?> signInAnonymously() async {
    final authData = await FirebaseAuth.instance.signInAnonymously();
    final token = await authData.user?.getIdToken();
    if (token != null) {
      await saveToken(token);
    }

    return token;
  }

  @override
  Future<bool> saveToken(String token) async {
    final prefs = await _getPrefs();
    return await prefs.setString(_tokenKey, token);
  }

  @override
  Future<String?> getToken() async {
    final prefs = await _getPrefs();
    return prefs.getString(_tokenKey);
  }

  Future<SharedPreferences> _getPrefs() async => await SharedPreferences.getInstance();

  static const _tokenKey = "TOKEN";
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl();
});
