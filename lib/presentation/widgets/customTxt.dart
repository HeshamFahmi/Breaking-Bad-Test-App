// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomTxt extends StatelessWidget {
  final String? title;
  final Color color;
  final double txtSize;
  final FontWeight txtWeight;
  const CustomTxt({
    Key? key,
    required this.title,
    required this.color,
    required this.txtSize,
    required this.txtWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      style: TextStyle(
        color: color,
        fontSize: txtSize,
        fontWeight: txtWeight,
      ),
    );
  }
}
