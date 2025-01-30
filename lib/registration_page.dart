import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:notebook/inputs/DefaultInputWidget.dart';
import 'package:notebook/services/user_service.dart';

class Registrationpage extends StatefulWidget {
  final String testeTitulo;

  const Registrationpage({super.key, this.testeTitulo = ''});

  @override
  State<Registrationpage> createState() => _Registrationpage();
}

class _Registrationpage extends State<Registrationpage> {
  UserService userService = UserService();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 116, 15, 136),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Registro'),
          Text(widget.testeTitulo),
          Defaultinputwidget(
              labelText: 'Usuário',
              hintText: 'Nome de usuário',
              hidden: false,
              controller: usernameController),
          Defaultinputwidget(
              labelText: 'Senha',
              hintText: 'Senha de usuário',
              hidden: true,
              controller: passwordController),
          FilledButton(
              onPressed: () async {
                try {
                  await userService.criarNovaConta(
                      "ju", usernameController.text, passwordController.text);
                  Navigator.of(context).pop();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Erro ao criar conta!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: const Text('Registrar')),
          FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Voltar'))
        ],
      )),
    );
  }
}
