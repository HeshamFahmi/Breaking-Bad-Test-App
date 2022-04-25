import 'package:flutter/material.dart';

import '../../constant/colors.dart';
import '../../data/modules/character_model.dart';
import 'customTxt.dart';

class SliverAppBarWidget extends StatelessWidget {
  final CharactersModel charactersModel;

  const SliverAppBarWidget({Key? key, required this.charactersModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.secondColor,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: CustomTxt(
          color: MyColors.thirdColor,
          title: charactersModel.nickname,
          txtSize: 20,
          txtWeight: FontWeight.bold,
        ),
        background: Hero(
          tag: charactersModel.charId!,
          child: Image.network(
            charactersModel.img!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
