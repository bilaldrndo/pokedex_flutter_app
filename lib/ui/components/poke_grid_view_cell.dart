import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/models/pokemon_model.dart';
import 'package:pokedex_app/ui/components/global_text_widget.dart';
import 'package:pokedex_app/utilities/helper_functions.dart';
import 'package:pokedex_app/utilities/theme.dart';

class PokeGridViewCell extends StatelessWidget {
  final Function() onTap;
  final PokemonModel pokemonModel;
  const PokeGridViewCell({
    super.key,
    required this.onTap,
    required this.pokemonModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: getBackgroundColorFromPokmemonIndex(pokemonModel.id!),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Center(
                  child: Hero(
                    tag: 'picture${pokemonModel.id}',
                    child: CachedNetworkImage(
                      imageUrl: pokemonModel.imageUrl!,
                      progressIndicatorBuilder: (conGlobalTextWidget, url, progress) => const CupertinoActivityIndicator(),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlobalTextWidget(
                      '#${pokemonModel.id!.toString().padLeft(3, '0')}',
                      color: CustomTheme.darkGrayTitleColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(height: 2),
                    FittedBox(
                      child: GlobalTextWidget(
                        parseName(pokemonModel.name!),
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    FittedBox(
                      child: GlobalTextWidget(
                        getTypesFromTypesClass(pokemonModel.types!),
                        color: CustomTheme.darkGrayTitleColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
