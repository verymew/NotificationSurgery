import 'package:flutter/material.dart';

class Datapickerwidget extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const Datapickerwidget(
      {super.key,
      required this.onDateSelected}); 

  @override
  State<Datapickerwidget> createState() => _Datapickerwidget();
}

class _Datapickerwidget extends State<Datapickerwidget> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 20),
          FilledButton.icon(
            label: const Text('Dia'),
            icon: const Icon(Icons.calendar_month_rounded),
            onPressed: () {  _selectDate(context); },
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      widget.onDateSelected(_selectedDate);
    }
  }
}
