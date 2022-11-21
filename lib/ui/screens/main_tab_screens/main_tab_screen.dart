import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex_app/models/hive_poke_model.dart';
import 'package:pokedex_app/provider/favourite_provider.dart';
import 'package:pokedex_app/provider/home_provider.dart';
import 'package:pokedex_app/services/hive_services.dart';
import 'package:pokedex_app/ui/components/appbar_with_logo.dart';
import 'package:pokedex_app/ui/components/circle_number_chip.dart';
import 'package:pokedex_app/ui/components/custom_tab_indicator.dart';
import 'package:pokedex_app/ui/screens/main_tab_screens/home_and_favourite_screen.dart';
import 'package:pokedex_app/utilities/theme.dart';
import 'package:provider/provider.dart';

class MainTabBarScreen extends StatefulWidget {
  const MainTabBarScreen({super.key});

  @override
  State<MainTabBarScreen> createState() => _MainTabBarScreenState();
}

class _MainTabBarScreenState extends State<MainTabBarScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  initialize() {
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  void dispose() {
    _tabController.dispose();
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    final favouriteProvider = Provider.of<FavouriteProvider>(context);

    return ValueListenableBuilder<Box<HivePokeModel>>(
      valueListenable: HiveService.getSavedPokemonsFromHive().listenable(),
      builder: (context, box, _) {
        final pokemonFromHive = box.values.toList().cast<HivePokeModel>();

        return _mainUi(
          pokemonFromHive,
          homeProvider,
          favouriteProvider,
        );
      },
    );
  }

  Widget _mainUi(pokemonFromHive, homeProvider, favouriteProvider) {
    return Scaffold(
      backgroundColor: CustomTheme.lightGreyBackgroundColor,
      appBar: const AppBarWithLogo(),
      body: Column(
        children: [
          const SizedBox(height: 2),
          _tabBarTop(pokemonFromHive),
          _tabBarBottom(homeProvider, favouriteProvider),
        ],
      ),
    );
  }

  Widget _tabBarTop(List<HivePokeModel> pokemonFromHive) {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: CustomTheme.darkBlueTitleColor,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        unselectedLabelColor: CustomTheme.darkGrayTitleColor,
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        indicator: CustomTabIndicator(
          color: CustomTheme.darkBluePrimaryColor,
          radius: 8,
          indicatorHeight: 4,
        ),
        tabs: [
          Tab(
            child: tabTitles(title: 'All Pokemons'),
          ),
          Tab(
            child: tabTitles(
              title: 'Favourites',
              isFavourite: true,
              favouriteCount: pokemonFromHive.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabBarBottom(homeProvider, favouriteProvider) {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: [
          HomeAndFavouriteScreen(
            provider: homeProvider,
          ),
          HomeAndFavouriteScreen(
            provider: favouriteProvider,
          ),
        ],
      ),
    );
  }

  Widget tabTitles({
    String? title,
    bool isFavourite = false,
    int favouriteCount = 0,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title!,
        ),
        SizedBox(width: (isFavourite) ? 4 : 0),
        (isFavourite) ? CircleNumberChip(number: favouriteCount) : const SizedBox(),
      ],
    );
  }
}
