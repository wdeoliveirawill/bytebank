import 'package:flutter/material.dart';

class FormItemField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final IconData? icon;

  const FormItemField({
    Key? key,
    required this.label,
    required this.hint,
    required this.controller,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 24),
        decoration: InputDecoration(
          icon: icon != null ? Icon(icon) : null,
          labelText: label,
          hintText: hint,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
