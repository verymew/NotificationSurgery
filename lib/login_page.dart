import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notebook/home_profile_page.dart';
import 'package:notebook/registration_page.dart';
import 'package:notebook/inputs/DefaultInputWidget.dart';
import 'package:notebook/services/user_service.dart';

class Loginpage extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final UserService userService = UserService();

  Loginpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 116, 15, 136),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 100.0,
            height: 150.0,
            child: Image.asset('assets/images/notepad.png', fit: BoxFit.cover),
          ),
          Defaultinputwidget(
            labelText: 'E-mail',
            hintText: 'Nome de usuário',
            hidden: false,
            controller: usernameController,
          ),
          Defaultinputwidget(
            labelText: 'Senha',
            hintText: 'Senha de usuário',
            hidden: true,
            controller: passwordController,
          ),
          FilledButton(
              onPressed: () async {
                try {
                  UserCredential userCredential = await userService.login(
                      usernameController.text, passwordController.text);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Homeprofilepage(
                        userData: userCredential,
                      ),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Erro de login!'),
                      duration: Duration(seconds: 2), 
                    ),
                  );
                }
              },
              child: const Text('Entrar')),
          TextButton(
              onPressed: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => Registrationpage()),
                    )
                  },
              child: const Text('Registrar'))
        ],
      )),
    );
  }
}
