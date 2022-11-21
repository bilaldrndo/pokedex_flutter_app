import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:pokedex_app/models/api_status.dart';
import 'package:pokedex_app/models/basic_model.dart';
import 'package:pokedex_app/models/hive_poke_model.dart';
import 'package:pokedex_app/models/pokemon_model.dart';
import 'package:pokedex_app/utilities/consts.dart';
import 'dart:async';

// Fetching will be done inside isolates so that we can spawn a new thread when fetching data and
// remove any possibilities of janky appereance

class APIRequests {
  String basicEndpoint = "https://pokeapi.co/api/v2/pokemon";
  int pokemonReturnLimit = 21;

  //Get a list of inital pokemons from the API Endpoint
  Future<Object> getInitialAndPaginatePokemons({int skip = 0}) async {
    try {
      String url = '$basicEndpoint?limit=$pokemonReturnLimit&offset=$skip';
      var response = await get(Uri.parse(url));
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        return Success(response: await parseInitialAndPaginatePokemonsInAnIsolate(response.body));
      }

      return Failure(response: ResponseMessages.MESSAGE_FAILURE_UNKNOWN, code: ResponseCodes.CODE_FAILURE_UNKNOWN);
    } on SocketException {
      return Failure(response: ResponseMessages.MESSAGE_FAILURE_NO_INTERNET, code: ResponseCodes.CODE_FAILURE_NO_INTERNET);
    } catch (e) {
      return Failure(response: e.toString(), code: ResponseCodes.CODE_FAILURE_UNKNOWN);
    }
  }

  Future<List<PokemonModel>> parseInitialAndPaginatePokemonsInAnIsolate(String encodedJson) {
    return compute(parseInitialAndPaginatePokemon, encodedJson);
  }

  Future<List<PokemonModel>> parseInitialAndPaginatePokemon(String encodedJson) async {
    Map<String, dynamic> response = jsonDecode(encodedJson);

    List pokemonResults = response['results'];

    List<PokemonModel> listOfPokemonsWithDetails = [];

    for (var pokemon in pokemonResults) {
      final pokemonInfo = BasicModel.fromJson(pokemon);
      final dataFromSpecifiPokeCall = await getDataAboutSpecificPokemon(pokemonInfo.url!);

      if (dataFromSpecifiPokeCall is Success) {
        listOfPokemonsWithDetails.add(dataFromSpecifiPokeCall.response as PokemonModel);
      }
    }
    return listOfPokemonsWithDetails;
  }

  //Get a list of pokemons from a list of hive pokemon objects based on their IDs
  Future<Object> getPokemonsFromFavourites(List<HivePokeModel> pokemonsFromHive) async {
    List<PokemonModel> listOfPokemonsWithDetails = [];

    for (var pokemon in pokemonsFromHive) {
      final dataFromSpecifiPokeCall = await getDataAboutSpecificPokemon('$basicEndpoint/${pokemon.id}');

      if (dataFromSpecifiPokeCall is Success) {
        listOfPokemonsWithDetails.add(dataFromSpecifiPokeCall.response as PokemonModel);
      }
      if (dataFromSpecifiPokeCall is Failure) {
        return dataFromSpecifiPokeCall;
      }
    }

    return Success(response: listOfPokemonsWithDetails);
  }

  //Get Data about a specfic pokemon based on its ID
  Future<Object> getDataAboutSpecificPokemon(String url) async {
    try {
      var response = await get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseFromIsolate = await getDataAboutSpecificPokemonInAnIsolate(response.body);
        return Success(response: responseFromIsolate);
      }

      return Failure(response: ResponseMessages.MESSAGE_FAILURE_UNKNOWN, code: ResponseCodes.CODE_FAILURE_UNKNOWN);
    } on SocketException {
      return Failure(response: ResponseMessages.MESSAGE_FAILURE_NO_INTERNET, code: ResponseCodes.CODE_FAILURE_NO_INTERNET);
    } catch (e) {
      return Failure(response: e.toString(), code: ResponseCodes.CODE_FAILURE_UNKNOWN);
    }
  }

  Future<PokemonModel> getDataAboutSpecificPokemonInAnIsolate(String encodedJson) {
    return compute(parseDataAboutASpecificPokemon, encodedJson);
  }

  PokemonModel parseDataAboutASpecificPokemon(String encodedJson) {
    Map<String, dynamic> response = jsonDecode(encodedJson);
    return PokemonModel.fromJson(response);
  }
}
