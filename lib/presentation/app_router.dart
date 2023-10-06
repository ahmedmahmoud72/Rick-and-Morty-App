import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/business_logic/cubit/characters_cubit.dart';
import 'package:rick_and_morty_app/data/repository/characters_repository.dart';
import 'package:rick_and_morty_app/presentation/screens/characters_screen.dart';

import 'constants/strings.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository();
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                CharactersCubit(charactersRepository),
            child: const CharactersScreen(),
          ),
        );
    }
    return null;
  }
}
