import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/data/models/charachters_model.dart';
import '../../data/repository/characters_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;

  CharactersCubit(
    this.charactersRepository,
  ) : super(CharactersInitial());

  Future<void> getAllCharacters() async {
    await charactersRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
    }).catchError((error) {
      print(error.toString());
    });
  }
}
