import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex_app/models/hive_poke_model.dart';
import 'package:pokedex_app/models/pokemon_model.dart';
import 'package:pokedex_app/provider/favourite_provider.dart';
import 'package:pokedex_app/services/hive_services.dart';
import 'package:pokedex_app/ui/components/back_btn.dart';
import 'package:pokedex_app/ui/components/base_stats_card.dart';
import 'package:pokedex_app/ui/components/floating_button.dart';
import 'package:pokedex_app/ui/components/poke_info_card.dart';
import 'package:pokedex_app/utilities/helper_functions.dart';
import 'package:pokedex_app/utilities/theme.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  final PokemonModel pokemonModel;
  const DetailsScreen({
    super.key,
    required this.pokemonModel,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Color backgroundColor;

  bool isPokemonSavedInHive(List<HivePokeModel> pokemonFromHive) {
    int indexOfPokemon = pokemonFromHive.indexWhere((element) => element.id == widget.pokemonModel.id);
    return (indexOfPokemon != -1) ? true : false;
  }

  initialize() {
    backgroundColor = getBackgroundColorFromPokmemonIndex(widget.pokemonModel.id);
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    final favouriteProvider = Provider.of<FavouriteProvider>(context);

    return ValueListenableBuilder<Box<HivePokeModel>>(
      valueListenable: HiveService.getSavedPokemonsFromHive().listenable(),
      builder: (context, box, _) {
        final pokemonFromHive = box.values.toList().cast<HivePokeModel>();

        return _mainUi(pokemonFromHive, favouriteProvider);
      },
    );
  }

  Widget _mainUi(pokemonFromHive, favouriteProvider) {
    return Scaffold(
      floatingActionButton: CustomFloatingBtn(
        isSmaller: !isPokemonSavedInHive(pokemonFromHive),
        onTap: () {
          if (!isPokemonSavedInHive(pokemonFromHive)) {
            favouriteProvider.addSinglePokeModelToPokemonList(widget.pokemonModel);
          } else {
            favouriteProvider.removeSinglePokeFromPokemonList(widget.pokemonModel.id!);
          }
        },
      ),
      body: Container(
        color: CustomTheme.lightGreyBackgroundColor,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              leading: const CustomBackBtn(),
              backgroundColor: backgroundColor,
              elevation: 1,
              forceElevated: true,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(278),
                child: PokeInfoCard(
                  backgroundColor: backgroundColor,
                  pokemonModel: widget.pokemonModel,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 8),
            ),
            SliverToBoxAdapter(
              child: BaseStatsCard(
                pokemonModel: widget.pokemonModel,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 10),
            ),
          ],
        ),
      ),
    );
  }
}
