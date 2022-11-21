import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pokedex_app/models/pokemon_model.dart';
import 'package:pokedex_app/ui/screens/details_screen.dart';

class NavigatorService {
  static openDetailsScreen(BuildContext context, PokemonModel pokemonModel) {
    Navigator.of(context).push(
      PageTransition(
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 220),
        child: DetailsScreen(pokemonModel: pokemonModel),
      ),
    );
  }
}
