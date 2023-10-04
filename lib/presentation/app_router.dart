import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/presentation/screens/characters_screen.dart';

import 'constants/strings.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.charactersScreen:
        return MaterialPageRoute(builder: (_) => const CharactersScreen());
    }
    return null;
  }
}
