// ignore_for_file: file_names

import 'package:breaking_bad/constant/colors.dart';
import 'package:flutter/material.dart';

class CharacterInfoDetails extends StatelessWidget {
  final String title;
  final String value;

  const CharacterInfoDetails(
      {Key? key, required this.title, required this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: [
        TextSpan(
          text: title,
          style: const TextStyle(
              color: MyColors.thirdColor,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        TextSpan(
            text: value,
            style: const TextStyle(color: MyColors.thirdColor, fontSize: 15))
      ]),
    );
  }
}
