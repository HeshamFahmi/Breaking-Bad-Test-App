// ignore_for_file: unnecessary_this

import 'package:bloc/bloc.dart';
import 'package:breaking_bad/data/modules/char_quotes.dart';
import 'package:breaking_bad/data/modules/character_model.dart';
import 'package:breaking_bad/data/repo/character_repo.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterRepository characterRepository;
  List<CharactersModel> characters = [];

  CharactersCubit(this.characterRepository) : super(CharactersInitial());

  List<CharactersModel> getAllCharacters() {
    characterRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }

  getAllCharactersQuotes(String charName) {
    characterRepository
        .getAllCharactersQuotes(charName)
        .then((charactersQuotes) {
      emit(CharactersQuotesLoaded(charactersQuotes));
    });
  }
}
