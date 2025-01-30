import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notebook/login_page.dart';
import 'package:notebook/services/notifica_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await NotificaService.init();
  } catch (e) {
    print("Erro ao inicializar o Firebase: $e");
  }
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Consultas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 208, 182, 253)),
        useMaterial3: true,
      ),
      home:  Loginpage(),
    );
  }
}
