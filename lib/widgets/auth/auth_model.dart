import 'package:flutter/cupertino.dart';
import 'package:flutter_first_try/domain/api_client/api_client.dart';
import 'package:flutter_first_try/domain/data_providers/session_data_provider.dart';
import 'package:flutter_first_try/ui/navigation/main_navigation.dart';

class AuthModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();

  final phoneController = TextEditingController(text: '79963297447');
  final passwordController = TextEditingController(text: '34940');
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;

  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  Future<void> auth(BuildContext context) async {
    String? token;
    final phone = phoneController.text;
    final password = passwordController.text;
    if (phone.isEmpty || password.isEmpty) {
      _errorMessage = 'Заполните логин и пароль';
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();
    try {
      token = await _apiClient.auth(phone: phone, password: password);
    } catch (e) {
      _errorMessage = 'Неправильный логин пароль!';
    }
    _isAuthProgress = false;
    if (_errorMessage != null) {
      notifyListeners();
    }
    if (token == null) {
      _errorMessage = 'Неизвестная ошибка';
      notifyListeners();
      return;
    }
    await _sessionDataProvider.setToken(token);
    Navigator.of(context)
        .pushReplacementNamed(MainNavigationRouteNames.mainScreen);
  }
}

class AuthProvider extends InheritedNotifier {
  final AuthModel model;

  const AuthProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
          key: key,
          notifier: model,
          child: child,
        );

  static AuthProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthProvider>();
  }

  static AuthProvider? read(BuildContext context) {
    final widget =
        context.getElementForInheritedWidgetOfExactType<AuthProvider>()?.widget;
    return widget is AuthProvider ? widget : null;
  }
}
