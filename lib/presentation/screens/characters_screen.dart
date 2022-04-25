// ignore_for_file: avoid_unnecessary_containers, avoid_print

import 'package:breaking_bad/business_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad/constant/colors.dart';
import 'package:breaking_bad/data/modules/character_model.dart';
import 'package:breaking_bad/presentation/widgets/characterItem.dart';
import 'package:breaking_bad/presentation/widgets/loadingIndicator.dart';
import 'package:breaking_bad/presentation/widgets/noInternert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<CharactersModel> allCharacters;
  late List<CharactersModel> searchedForCharacters;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.secondColor,
      decoration: InputDecoration(
        hintText: 'Find a character...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.secondColor, fontSize: 18),
      ),
      style: TextStyle(color: MyColors.secondColor, fontSize: 18),
      onChanged: (searchedCharacter) {
        addSearchedFOrItemsToSearchedList(searchedCharacter);
      },
    );
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _stopSearching();
            Navigator.pop(context);
          },
          icon: Icon(Icons.clear, color: MyColors.secondColor),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: Icon(
            Icons.search,
            color: MyColors.secondColor,
          ),
        ),
      ];
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = (state).characters;
          return SingleChildScrollView(
            child: Container(
              color: MyColors.secondColor,
              child: Column(
                children: [
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                    ),
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: _searchTextController.text.isEmpty
                        ? allCharacters.length
                        : searchedForCharacters.length,
                    itemBuilder: (ctx, index) {
                      return CharacterItem(
                        character: _searchTextController.text.isEmpty
                            ? allCharacters[index]
                            : searchedForCharacters[index],
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return const LoadingIndicator();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.mainColor,
        leading: _isSearching
            ? BackButton(
                color: MyColors.secondColor,
              )
            : Container(),
        title: _isSearching
            ? _buildSearchField()
            : Text(
                'Characters',
                style: TextStyle(color: MyColors.secondColor),
              ),
        actions: _buildAppBarActions(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;

          if (connected) {
            return buildBlocWidget();
          } else {
            return const NoInternet();
          }
        },
        child: const LoadingIndicator(),
      ),
    );
  }

  void addSearchedFOrItemsToSearchedList(String searchedCharacter) {
    searchedForCharacters = allCharacters
        .where((character) =>
            character.name!.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    setState(() {
      _searchTextController.clear();
      _isSearching = false;
    });
  }
}
