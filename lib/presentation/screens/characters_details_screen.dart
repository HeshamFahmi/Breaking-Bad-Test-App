// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breaking_bad/business_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad/constant/colors.dart';
import 'package:breaking_bad/data/modules/character_model.dart';
import 'package:breaking_bad/presentation/widgets/characterInfoDetails.dart';
import 'package:breaking_bad/presentation/widgets/divider.dart';
import 'package:breaking_bad/presentation/widgets/loadingIndicator.dart';
import 'package:breaking_bad/presentation/widgets/sliverAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetialsScreen extends StatelessWidget {
  final CharactersModel charactersModel;
  const CharacterDetialsScreen({
    Key? key,
    required this.charactersModel,
  }) : super(key: key);

  Widget checkIfQuotesAreLoaded(CharactersState state) {
    if (state is CharactersQuotesLoaded) {
      return displayRandomQuoteOrEmptySpace(state);
    } else {
      return LoadingIndicator();
    }
  }

  Widget displayRandomQuoteOrEmptySpace(state) {
    var quotes = (state).charactersQuotes;
    if (quotes.length != 0) {
      int randomQuoteIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: MyColors.thirdColor,
            shadows: const [
              Shadow(
                blurRadius: 7,
                color: MyColors.mainColor,
                offset: Offset(0, 0),
              )
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context)
        .getAllCharactersQuotes(charactersModel.name!);
    return Scaffold(
      backgroundColor: MyColors.secondColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBarWidget(
            charactersModel: charactersModel,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
                margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CharacterInfoDetails(
                        title: "Job : ",
                        value: charactersModel.occupation!.join(" - ")),
                    DividerWidget(
                      endIndet: MediaQuery.of(context).size.width * 0.82,
                    ),
                    CharacterInfoDetails(
                        title: "Appeared in : ",
                        value: charactersModel.category!),
                    DividerWidget(
                      endIndet: MediaQuery.of(context).size.width * 0.65,
                    ),
                    CharacterInfoDetails(
                        title: "Seasons : ",
                        value: charactersModel.appearance!.join(" - ")),
                    DividerWidget(
                      endIndet: MediaQuery.of(context).size.width * 0.73,
                    ),
                    CharacterInfoDetails(
                        title: "Status : ", value: charactersModel.status!),
                    DividerWidget(
                      endIndet: MediaQuery.of(context).size.width * 0.76,
                    ),
                    charactersModel.betterCallSaulAppearance!.isEmpty
                        ? Container()
                        : CharacterInfoDetails(
                            title: "Better Call Saul Appearance : ",
                            value: charactersModel.betterCallSaulAppearance!
                                .join(" - ")),
                    charactersModel.betterCallSaulAppearance!.isEmpty
                        ? Container()
                        : DividerWidget(
                            endIndet: MediaQuery.of(context).size.width * 0.33,
                          ),
                    CharacterInfoDetails(
                        title: "Actor/Actress : ",
                        value: charactersModel.portrayed!),
                    DividerWidget(
                      endIndet: MediaQuery.of(context).size.width * 0.60,
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    BlocBuilder<CharactersCubit, CharactersState>(
                      builder: (context, state) {
                        return checkIfQuotesAreLoaded(state);
                      },
                    ),
                  ],
                )),
            SizedBox(
              height: 500,
            ),
          ]))
        ],
      ),
    );
  }
}
