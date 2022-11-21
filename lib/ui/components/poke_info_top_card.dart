import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/models/pokemon_model.dart';
import 'package:pokedex_app/ui/components/global_text_widget.dart';
import 'package:pokedex_app/utilities/consts.dart';
import 'package:pokedex_app/utilities/helper_functions.dart';
import 'package:pokedex_app/utilities/theme.dart';

class PokemonInfoTopCard extends StatelessWidget {
  final Color backgroundColor;
  final PokemonModel pokemonModel;

  const PokemonInfoTopCard({
    super.key,
    required this.backgroundColor,
    required this.pokemonModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: backgroundColor,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 23, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GlobalTextWidget(
                    parseName(pokemonModel.name!),
                    color: CustomTheme.darkBlueTitleColor,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(height: 5),
                  GlobalTextWidget(
                    getTypesFromTypesClass(pokemonModel.types!),
                    color: CustomTheme.darkBlueTitleColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 14),
              child: GlobalTextWidget(
                '#${pokemonModel.id!.toString().padLeft(3, '0')}',
                color: CustomTheme.darkBlueTitleColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            right: 0,
            child: Image.asset(
              Constants.assetPokeballPath,
              width: 130,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
              child: Hero(
                tag: 'picture${pokemonModel.id}',
                child: CachedNetworkImage(
                  imageUrl: pokemonModel.imageUrl!,
                  height: 140,
                  width: 140,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
