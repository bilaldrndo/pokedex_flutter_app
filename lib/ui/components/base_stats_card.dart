import 'package:flutter/material.dart';
import 'package:pokedex_app/models/pokemon_model.dart';
import 'package:pokedex_app/ui/components/basic_staistic_cell_with_indicator.dart';
import 'package:pokedex_app/ui/components/global_text_widget.dart';
import 'package:pokedex_app/utilities/helper_functions.dart';
import 'package:pokedex_app/utilities/theme.dart';

class BaseStatsCard extends StatelessWidget {
  final PokemonModel pokemonModel;

  const BaseStatsCard({
    super.key,
    required this.pokemonModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: CustomTheme.defaultCardBoxShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
            child: GlobalTextWidget(
              'Base Stats',
              color: CustomTheme.darkBlueTitleColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            height: 1,
            color: CustomTheme.lightGreyBackgroundColor,
          ),
          const SizedBox(height: 16),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pokemonModel.stats!.length + 1,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              return BasicStatisticCellWithIndicator(
                stat: (index != pokemonModel.stats!.length)
                    ? pokemonModel.stats![index]
                    : Stats(
                        statName: "Avg. Power",
                        statValue: calculateAveragePower(pokemonModel),
                      ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 24);
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
