import 'package:flutter/material.dart';

class Dropdownwidget extends StatefulWidget {
  final Function(String) onValueChanged;

  const Dropdownwidget({super.key, required this.onValueChanged});

  @override
  State<Dropdownwidget> createState() => _Dropdownwidget();
}

class _Dropdownwidget extends State<Dropdownwidget> {
  List<String> lista = <String>['One', 'Two', 'Three', 'Four'];
  String valorAtual = "";

  @override
  void initState() {
    super.initState();
    valorAtual = lista[0];  
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 50,
      child: DropdownButton<String>(
        value: valorAtual,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? value) {
          setState(() {
            valorAtual = value!;
            widget.onValueChanged(valorAtual);
          });
        },
        items: lista.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
