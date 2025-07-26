import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {required this.controller,
      required this.labText,
      // required this.keyboardType,
      super.key});
  final TextEditingController controller;
  final String labText;
  // final TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextField(
      // keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        labelText: labText,
      ),
    );
  }
}
