import 'package:flutter/material.dart';

class TextformField extends StatelessWidget {
  const TextformField(
      {super.key,
      required this.hinttext,
      required this.controller,
      this.isobscureText = false,
      this.keyboardText,
      this.validator});
  final String hinttext;
  final bool isobscureText;
  final TextInputType? keyboardText;
  //final dynamic keyboardText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: validator,
        controller: controller,
        keyboardType: keyboardText,
        obscureText: isobscureText,
        decoration: InputDecoration(
            hintText: hinttext, border: const OutlineInputBorder()));
  }
}
