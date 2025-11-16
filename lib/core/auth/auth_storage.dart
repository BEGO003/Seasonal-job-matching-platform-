import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage {
  static const _tokenKey = 'auth_token';
  static const _userKey = 'auth_user_json';
  final FlutterSecureStorage _storage;

  AuthStorage([FlutterSecureStorage? storage])
      : _storage = storage ?? const FlutterSecureStorage();

  Future<void> saveToken(String token) => _storage.write(key: _tokenKey, value: token);
  Future<String?> getToken() => _storage.read(key: _tokenKey);
  Future<void> clearToken() => _storage.delete(key: _tokenKey);

  Future<void> saveUserJson(String userJson) => _storage.write(key: _userKey, value: userJson);
  Future<String?> getUserJson() => _storage.read(key: _userKey);
  Future<void> clearUser() => _storage.delete(key: _userKey);
}


