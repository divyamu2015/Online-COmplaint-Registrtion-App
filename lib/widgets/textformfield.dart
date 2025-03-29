import 'package:flutter/material.dart';

class Textform extends StatefulWidget {
  const Textform({
    super.key,
    required this.inputType,
    required this.controller,
    required this.hintText,
    required this.fontSize,
    required this.textColor,
    this.validator,
    this.maxLin,
  });

  final TextInputType inputType;
  final TextEditingController controller;
  final String hintText;
  final double fontSize;
  final Color textColor;
  final int? maxLin;
   final String? Function(String?)? validator; // Properly defined validator function

  @override
  State<Textform> createState() => _TextformState();
}

class _TextformState extends State<Textform> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator:widget.validator ,
      maxLines: widget.maxLin,
      keyboardType: widget.inputType,
      controller: widget.controller,
      style: TextStyle(
        fontSize: widget.fontSize,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: const OutlineInputBorder(),
        hintStyle:
            TextStyle(fontSize: widget.fontSize, color: widget.textColor),
      ),
    );
  }
}
