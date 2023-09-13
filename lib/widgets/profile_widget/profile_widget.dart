import 'package:flutter/material.dart';
import 'package:flutter_first_try/domain/data_providers/session_data_provider.dart';
import 'package:flutter_first_try/ui/navigation/main_navigation.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});
  // logout(context) {
  //   SessionDataProvider().setToken(null);
  //   Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.auth);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(
            height: 200,
          ),
          Row(children: [
            IconButton(
                onPressed: () {
                  SessionDataProvider().setToken(null);
                  Navigator.of(context)
                      .pushReplacementNamed(MainNavigationRouteNames.auth);
                }, //logout(context),
                icon: Icon(Icons.login)),
            const Text('Выйти из профиля')
          ])
        ],
      )),
    );
  }
}
