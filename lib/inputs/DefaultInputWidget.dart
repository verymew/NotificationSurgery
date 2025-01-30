import 'package:flutter/material.dart';

class Defaultinputwidget extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool hidden;
  final TextEditingController controller;  


  const Defaultinputwidget({
    super.key,
    required this.labelText,
    required this.hidden,
    required this.hintText,
    required this.controller,  
  });
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: 250,
        child: TextField(
          controller: controller,
          obscureText: hidden,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: labelText,
            labelStyle: const TextStyle(
              color: Color.fromARGB(255, 44, 13, 97),
              fontSize: 18,
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 50, 17, 102),
                width: 2.0,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
