import 'package:flutter/material.dart';
import 'package:pokedex_app/models/api_status.dart';
import 'package:pokedex_app/models/hive_poke_model.dart';
import 'package:pokedex_app/models/pokemon_model.dart';
import 'package:pokedex_app/services/api_requests.dart';
import 'package:pokedex_app/services/hive_services.dart';

class FavouriteProvider extends ChangeNotifier {
  FavouriteProvider() {
    getInitialPokemonsOrPaginate();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setLoading(bool load) {
    _isLoading = load;
    notifyListeners();
  }

  List<PokemonModel> _pokemonList = [];
  List<PokemonModel> get pokemonsList => _pokemonList;

  setPokemonList(List<PokemonModel> poke) {
    _pokemonList = poke;
  }

  addToPokemonList(List<PokemonModel> poke) {
    _pokemonList.addAll(poke);
    notifyListeners();
  }

  addSinglePokeModelToPokemonList(PokemonModel poke) {
    _pokemonList.insert(0, poke);
    notifyListeners();
    HiveService.addToPokemonHiveDatabase(id: poke.id!, name: poke.name!);
  }

  removeSinglePokeFromPokemonList(int id) {
    _pokemonList.removeWhere((element) => element.id == id);
    notifyListeners();
    HiveService.removePokemonFromHiveDatabase(id);
  }

  Failure _error = Failure(code: 0); //code 0 means that there is no error, just here for initalization purposes
  Failure get error => _error;

  setError(Failure err) {
    _error = err;
    notifyListeners();
  }

  Future getInitialPokemonsOrPaginate({bool isPaginate = false}) async {
    !isPaginate ? setLoading(true) : null;

    List<HivePokeModel> pokemons = HiveService.getInitialPokemonAndPaginated(
      skip: (_pokemonList.isEmpty) ? 0 : _pokemonList.length,
    );

    var response = await APIRequests().getPokemonsFromFavourites(pokemons);

    if (response is Success) {
      final pokemonList = response.response as List<PokemonModel>;

      if (_pokemonList.isEmpty) {
        setPokemonList(pokemonList);
      } else {
        addToPokemonList(pokemonList);
      }
    }
    if (response is Failure) {
      setError(response);
    }

    !isPaginate ? setLoading(false) : null;
  }
}
