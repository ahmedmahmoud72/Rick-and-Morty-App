import 'package:rick_and_morty_app/data/models/charachters_model.dart';
import 'package:rick_and_morty_app/data/web_services/dio_helper.dart';
import 'package:rick_and_morty_app/presentation/constants/strings.dart';

class CharactersRepository {
  CharactersModel? charactersModel;

  Future<List<Results>> getAllCharacters() async {
    await DioHelper.getData(url: AppEndPoints.character).then(
      (value) {
        charactersModel = CharactersModel.fromJson(value.data);
      },
    );
    return charactersModel!.results!;
  }
}
