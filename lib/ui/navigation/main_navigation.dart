import 'package:flutter/material.dart';
import 'package:flutter_first_try/widgets/auth/auth_model.dart';
import 'package:flutter_first_try/widgets/auth/auth_widget.dart';
import 'package:flutter_first_try/widgets/main_screen/main_screen_widget.dart';

abstract class MainNavigationRouteNames {
  static const auth = 'auth';
  static const mainScreen = '/';
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRouteNames.mainScreen
      : MainNavigationRouteNames.auth;
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.auth: (context) =>
        AuthProvider(model: AuthModel(), child: const AuthWidget()),
    MainNavigationRouteNames.mainScreen: (context) => const MainScreenWidget(),
  };
}
