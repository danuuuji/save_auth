import 'package:flutter/material.dart';
import 'package:flutter_first_try/widgets/auth/auth_model.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const _sizeTextBlack = TextStyle(fontSize: 20.0, color: Colors.black);

    final model = AuthProvider.read(context)?.model;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Авторизация'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const _ErrorMessageWidget(),
          SizedBox(
            width: 200.0,
            child: TextFormField(
              controller: model?.phoneController,
              decoration: const InputDecoration(
                  labelText: "Телефон", border: OutlineInputBorder()),
              keyboardType: TextInputType.phone,
              style: _sizeTextBlack,
              // inputFormatters: [MaskedInputFormatter('(###) ###-##-##')],
            ),
          ),
          Container(
            width: 200.0,
            padding: const EdgeInsets.only(top: 10.0),
            child: TextFormField(
              controller: model?.passwordController,
              decoration: const InputDecoration(
                  labelText: "Пароль", border: OutlineInputBorder()),
              obscureText: true,
              style: _sizeTextBlack,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 25.0),
            child: _AuthButtonWidget(),
          )
        ],
      )),
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget();

  @override
  Widget build(BuildContext context) {
    final model = AuthProvider.watch(context)?.model;
    const _sizeTextWhite = TextStyle(fontSize: 20.0, color: Colors.white);
    final onPressed =
        model?.canStartAuth == true ? () => model?.auth(context) : null;
    final child = model?.isAuthProgress == true
        ? const SizedBox(child: CircularProgressIndicator())
        : const Text(
            "Авторизоваться",
            style: _sizeTextWhite,
          );
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget();

  @override
  Widget build(BuildContext context) {
    final errorMessage = AuthProvider.watch(context)?.model.errorMessage;
    if (errorMessage == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        errorMessage,
        style: const TextStyle(fontSize: 18, color: Colors.red),
      ),
    );
  }
}
