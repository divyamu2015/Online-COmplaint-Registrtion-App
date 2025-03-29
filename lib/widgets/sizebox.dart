import 'package:flutter/material.dart';

class Sizebox extends StatelessWidget {
  const Sizebox({super.key, required this.he, required this.wi});
  final double he;
  final double wi;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: he,
      width: wi,
    );
  }
}
