import 'package:flutter/material.dart';

import '../../constant/colors.dart';

class DividerWidget extends StatelessWidget {
  final double endIndet;
  const DividerWidget({
    Key? key,
    required this.endIndet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 2,
      height: 30,
      endIndent: endIndet,
      color: MyColors.mainColor,
    );
  }
}
