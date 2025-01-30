import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notebook/inputs/DataPickerWidget.dart';
import 'package:notebook/inputs/DefaultInputWidget.dart';
import 'package:notebook/inputs/DropDownWidget.dart';
import 'package:notebook/nova_consulta_page.dart';
import 'package:notebook/services/consulta_service.dart';
import 'package:notebook/services/utils_service.dart';

class CardsConsulta extends StatefulWidget {
  final UserCredential userData;

  const CardsConsulta({super.key, required this.userData});

  @override
  State<CardsConsulta> createState() => _CardsConsulta();
}

class _CardsConsulta extends State<CardsConsulta> {
  ConsultaService consultaService = ConsultaService();
  UtilsService utilsService = UtilsService();

  TextEditingController nome = TextEditingController();
  DateTime _dataEscolhida = DateTime.now();
  Map<String, bool> editando = {};
  String valorSelecionado = "";

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: consultaService.listarTodosPorId(widget.userData.user?.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar dados'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Nenhuma consulta encontrada'));
          }

          final consultas = snapshot.data!.docs;

          return Center(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var consulta in consultas)
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: ListTile(
                            leading: const Icon(Icons.album),
                            title: editando[consulta.id] == true
                                ? Defaultinputwidget(
                                    labelText: 'labelText',
                                    hidden: false,
                                    hintText: 'hintText',
                                    controller: nome,
                                  )
                                : Text(consulta['nome']),
                            subtitle: editando[consulta.id] == true
                                ? Column(
                                    children: [
                                      Datapickerwidget(
                                          onDateSelected: _updateData),
                                      Dropdownwidget(
                                          onValueChanged: _atualizarValor)
                                    ],
                                  )
                                : Text(
                                    "Tipo: ${consulta['tipo']} Dia: ${utilsService.formatarData(consulta['data'])}"),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              child: const Text('Editar'),
                              onPressed: () {
                                setState(() {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => 
                                            NovaConsultaPage(isEditing: true, dados: consulta)),
                                  );
                                });
                              },
                            ),
                            const SizedBox(width: 8),
                            TextButton(
                              child: const Text('Remover'),
                              onPressed: () {
                                setState(() {
                                  consultaService.excluir(consulta.id);
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    )
                ],
              ),
            ),
          );
        });
  }

  void _updateData(DateTime selectedDate) {
    setState(() {
      _dataEscolhida = selectedDate;
    });
  }

  void _atualizarValor(String novoValor) {
    setState(() {
      valorSelecionado = novoValor;
    });
  }
}
