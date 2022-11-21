import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/services/navigator_service.dart';
import 'package:pokedex_app/ui/components/global_text_widget.dart';
import 'package:pokedex_app/ui/components/poke_grid_view_cell.dart';
import 'package:pokedex_app/utilities/theme.dart';

class HomeAndFavouriteScreen extends StatefulWidget {
  final provider;

  const HomeAndFavouriteScreen({
    super.key,
    required this.provider,
  });

  @override
  State<HomeAndFavouriteScreen> createState() => _HomeAndFavouriteScreenState();
}

class _HomeAndFavouriteScreenState extends State<HomeAndFavouriteScreen> {
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  initializeScrollController() {
    _scrollController.addListener(() async {
      double currentScroll = _scrollController.position.pixels;
      double maxScroll = _scrollController.position.maxScrollExtent;
      double delta = 100;

      if (maxScroll - currentScroll <= delta) {
        if (!isLoading) {
          isLoading = true;
          setState(() {});
          await widget.provider.getInitialPokemonsOrPaginate(isPaginate: true);
          isLoading = false;
          setState(() {});
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initializeScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return _mainUi(widget.provider);
  }

  Widget _mainUi(provider) {
    if (provider.isLoading) {
      return const Center(child: CupertinoActivityIndicator());
    }
    if (provider.error.code != 0) {
      return centerText(
        'Error Message: ${provider.error.response}, Code: ${provider.error.code}',
        isError: true,
      );
    }
    if (provider.pokemonsList.isEmpty) {
      return centerText('No Pokemons to Show!');
    }
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: ((MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio) > 1536)
                        ? 4
                        : 3, //If the width of the width is greater than iPad Minis (1536), it will have 4 items in a row
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.59, //i.e 110/186
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) => PokeGridViewCell(
                      pokemonModel: provider.pokemonsList[index],
                      onTap: () {
                        NavigatorService.openDetailsScreen(context, provider.pokemonsList[index]);
                      },
                    ),
                    childCount: provider.pokemonsList.length,
                  ),
                ),
              ),
              if (isLoading)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: CupertinoActivityIndicator(),
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }

  Widget centerText(String text, {bool isError = false}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GlobalTextWidget(
          text,
          color: (!isError) ? CustomTheme.darkBlueTitleColor : Colors.red,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
