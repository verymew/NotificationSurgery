import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notebook/nova_consulta_page.dart';
import 'package:notebook/services/consulta_service.dart';
import 'package:notebook/utils/cards_consulta.dart';

class Homeprofilepage extends StatefulWidget {
  final UserCredential userData;

  const Homeprofilepage({super.key, required this.userData});

  @override
  State<Homeprofilepage> createState() => _Homeprofilepage();
}

class _Homeprofilepage extends State<Homeprofilepage> {
  ConsultaService consultaService = ConsultaService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 116, 15, 136),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CardsConsulta(userData: widget.userData ),
          FilledButton(
              onPressed: () async {
                setState(() {});
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => NovaConsultaPage(isEditing: false, dados: widget.userData)),
                    ),
                  );
              },
              child: const Text('Nova Consulta'))
        ],
      )),
    );
  }
}
