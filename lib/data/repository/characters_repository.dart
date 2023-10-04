import 'package:rick_and_morty_app/data/models/charachters_model.dart';
import 'package:rick_and_morty_app/data/web_services/dio_helper.dart';
import 'package:rick_and_morty_app/presentation/constants/strings.dart';

class CharactersRepository {
  CharactersModel? characterModel;

  Future<List<CharactersModel>> getAllCharacters() async {
    await DioHelper.getData(url: AppEndPoints.character).then(
      (value) {
        characterModel = CharactersModel.fromJson(value.data);
        return characterModel;
      },
    );
    return [];
  }
}
