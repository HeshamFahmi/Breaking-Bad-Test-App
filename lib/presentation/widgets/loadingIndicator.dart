// ignore_for_file: file_names

import 'package:breaking_bad/constant/colors.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.mainColor,
      ),
    );
  }
}
