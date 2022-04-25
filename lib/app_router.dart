import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic/cubit/characters_cubit.dart';
import 'constant/strings.dart';
import 'data/modules/character_model.dart';
import 'data/repo/character_repo.dart';
import 'data/web_services/character_web_services.dart';
import 'presentation/screens/characters_details_screen.dart';
import 'presentation/screens/characters_screen.dart';

class AppRouter {
  late CharacterRepository characterRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    characterRepository = CharacterRepository(CharacterWebServices());
    charactersCubit = CharactersCubit(characterRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => charactersCubit,
                  child: const CharactersScreen(),
                ));
      case charactersDetailsScreen:
        final characterModel = settings.arguments as CharactersModel;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => CharactersCubit(characterRepository),
                  child:
                      CharacterDetialsScreen(charactersModel: characterModel),
                ));
    }
  }
}
