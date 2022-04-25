import '../modules/char_quotes.dart';
import '../modules/character_model.dart';
import '../web_services/character_web_services.dart';

class CharacterRepository {
  final CharacterWebServices characterWebServices;

  CharacterRepository(this.characterWebServices);

  Future<List<CharactersModel>> getAllCharacters() async {
    final characters = await characterWebServices.getAllcharacters();

    return characters
        .map((character) => CharactersModel.fromJson(character))
        .toList();
  }

  Future<List<CharQoutes>> getAllCharactersQuotes(String charName) async {
    final charactersQuotes =
        await characterWebServices.getAllcharactersQuotes(charName);

    return charactersQuotes
        .map((charactersQuotes) => CharQoutes.fromJson(charactersQuotes))
        .toList();
  }
}
