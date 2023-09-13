import 'package:flutter_first_try/domain/data_providers/session_data_provider.dart';

class MyAppModel {
  final _sessionDataProvider = SessionDataProvider();
  var _isAuth = false;
  bool get isAuth => _isAuth;

  Future<void> checkAuth() async {
    final token = await _sessionDataProvider.getToken();
    _isAuth = token != null;
  }
}
