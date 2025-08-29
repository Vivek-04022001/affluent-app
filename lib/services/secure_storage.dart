import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  // Create an instance of FlutterSecureStorage
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // bearer token methods
  Future<void> storeBearerToken(String token) async {
    await _storage.write(key: 'bearer_token', value: token);
  }

  Future<String?> getBearerToken() async {
    return _storage.read(key: 'bearer_token');
  }

  Future<void> deleteBearerToken() async {
    await _storage.delete(key: 'bearer_token');
  }

  // clear all data
  Future<void> clearAllData() async {
    await _storage.deleteAll();
  }
}
