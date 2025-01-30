import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notebook/inputs/DataPickerWidget.dart';
import 'package:notebook/inputs/DefaultInputWidget.dart';
import 'package:notebook/plugins/calendar_plugin.dart';
import 'package:notebook/services/consulta_service.dart';
import 'package:notebook/services/notifica_service.dart';
import 'package:notebook/services/utils_service.dart';

class NovaConsultaPage extends StatefulWidget {
  final bool isEditing;
  final dynamic dados;

  const NovaConsultaPage(
      {super.key, required this.isEditing, required this.dados});

  @override
  State<NovaConsultaPage> createState() => _NovaConsultaPage();
}

class _NovaConsultaPage extends State<NovaConsultaPage> {
  final TextEditingController nome = TextEditingController();
  DateTime _dataEscolhida = DateTime.now();
  ConsultaService consultaService = ConsultaService();
  UtilsService utilsService = UtilsService();
  CalendarPlugin calendarPlugin = CalendarPlugin();
  String tipoEscolhido = "";

  @override
  void initState() {
    super.initState();
    if (widget.isEditing) {
      nome.text = widget.dados['nome'];
      tipoEscolhido = widget.dados['tipo'];

      if (widget.dados['data'] is Timestamp) {
        _dataEscolhida = (widget.dados['data'] as Timestamp).toDate();
      } else if (widget.dados['data'] is String) {
        _dataEscolhida = DateTime.parse(widget.dados['data']);
      } else {
        _dataEscolhida = DateTime.now();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 116, 15, 136),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Defaultinputwidget(
              labelText: 'Nome',
              hidden: false,
              hintText: 'Digite o nome',
              controller: nome,
            ),
            const Text('Tipo de consulta:'),
            ListTile(
              title: const Text('Limpeza'),
              leading: Radio<String>(
                value: "limpeza",
                groupValue: tipoEscolhido,
                onChanged: (String? value) {
                  setState(() {
                    tipoEscolhido = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Manutenção'),
              leading: Radio<String>(
                value: "manutenção",
                groupValue: tipoEscolhido,
                onChanged: (String? value) {
                  setState(() {
                    tipoEscolhido = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Remoção'),
              leading: Radio<String>(
                value: 'remoção',
                groupValue: tipoEscolhido,
                onChanged: (String? value) {
                  setState(() {
                    tipoEscolhido = value!;
                  });
                },
              ),
            ),
            Datapickerwidget(onDateSelected: _updateData),
            FilledButton(
                onPressed: () async {
                  if (widget.isEditing) {
                    try {
                      await consultaService.editar(widget.dados.id, nome.text,
                          tipoEscolhido, _dataEscolhida);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Erro ao salvar!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  } else {
                    try {
                      consultaService.gravarConsulta(
                          nome.text, _dataEscolhida, tipoEscolhido);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Erro ao salvar!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  }
                  Navigator.of(context).pop();
                },
                child: const Text('Salvar Consulta')),
            FilledButton(
              onPressed: () async {
                if (nome.text.isNotEmpty && tipoEscolhido.isNotEmpty) {
                  await NotificaService.requestNotificationPermission();
                  await NotificaService.scheduleNotification(
                    nome.text,
                    _dataEscolhida,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: _dataEscolhida.isAfter(DateTime.now())
                          ? const Text("Notificação agendada com sucesso!")
                          : const Text("Notificação exibida imediatamente!"),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Preencha todos os campos antes de lembrar!")),
                  );
                }
              },
              child: const Text('Lembrar'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateData(DateTime selectedDate) {
    setState(() {
      _dataEscolhida = selectedDate;
    });
  }
}
