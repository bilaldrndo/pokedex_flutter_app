import 'package:flutter/material.dart';
import 'package:pokedex_app/models/basic_info_model.dart';
import 'package:pokedex_app/models/pokemon_model.dart';
import 'package:pokedex_app/ui/components/basic_info_card.dart';
import 'package:pokedex_app/ui/components/poke_info_top_card.dart';
import 'package:pokedex_app/utilities/helper_functions.dart';
import 'package:pokedex_app/utilities/theme.dart';

class PokeInfoCard extends StatelessWidget {
  final Color backgroundColor;
  final PokemonModel pokemonModel;

  const PokeInfoCard({
    super.key,
    required this.backgroundColor,
    required this.pokemonModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: CustomTheme.defaultCardBoxShadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PokemonInfoTopCard(
            backgroundColor: backgroundColor,
            pokemonModel: pokemonModel,
          ),
          BasicInfoCard(
            listOfStats: [
              BasicInfoModel(
                name: 'Height',
                value: pokemonModel.height!,
              ),
              BasicInfoModel(
                name: 'Weight',
                value: pokemonModel.weight!,
              ),
              BasicInfoModel(
                name: 'BMI',
                value: calulcateBMI(pokemonModel),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
