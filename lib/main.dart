import 'package:flutter/material.dart';
import 'package:flutter_first_try/widgets/auth/auth_model.dart';
import 'package:flutter_first_try/widgets/auth/auth_widget.dart';
import 'package:flutter_first_try/widgets/main_screen/main_screen_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/auth': (context) =>
            AuthProvider(
                model: AuthModel(),
                child: const AuthWidget()
            ),
        '/main_screen': (context) => const MainScreenWidget(),
      },
      initialRoute: '/auth',
      //home: AuthWidget()
    );
  }
}
