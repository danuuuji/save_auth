import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _Keys {
  static const token = 'token';
}

class SessionDataProvider {
  static const _secureStorage = FlutterSecureStorage();
  Future<String?> getToken() async => _secureStorage.read(key: _Keys.token);
  Future<void> setToken(String value) =>
      _secureStorage.write(key: _Keys.token, value: value);
}
