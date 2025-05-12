import 'package:flutter/material.dart';
import 'package:sehetne_provider/core/Colors.dart';

class CustomTxt extends StatelessWidget {
  final String txt;
  final double size;
  const CustomTxt({super.key, required this.txt, required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(
        color: kSecondaryColor,
        fontSize: size,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
