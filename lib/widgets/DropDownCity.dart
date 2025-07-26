import 'package:flutter/material.dart';

class DropdownButtonCity extends StatefulWidget {
  const DropdownButtonCity({super.key});

  @override
  State<DropdownButtonCity> createState() => _DropdownButtonCity();
}

const List<String> list = <String>[
  'City',
  'Patna',
  'Bhagalpur',
  'Gaya',
  'Muzaffarpur',
  'Bihar Sharif',
  'Munger',
  'Samastipur'
];

class _DropdownButtonCity extends State<DropdownButtonCity> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.keyboard_arrow_down),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: Colors.grey,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
