import 'package:flutter/material.dart';
import 'package:pokedex_app/models/pokemon_model.dart';
import 'package:pokedex_app/utilities/extensions.dart';

//Gets Bg color from the pokemons index
Color getBackgroundColorFromPokmemonIndex(index) {
  return Color(((1000 / index) * 0xFFFFFF).toInt()).withAlpha(0xff);
}

Color getBarLineColorBasedOnStatValue(int value) {
  if (value >= 0 && value < 40) {
    return const Color.fromRGBO(205, 40, 115, 1);
  } else if (value >= 40 && value < 70) {
    return const Color.fromRGBO(238, 194, 24, 1);
  } else {
    return Colors.green;
  }
}

int calculateAveragePower(PokemonModel pokemonModel) {
  int sum = 0;
  for (var stat in pokemonModel.stats!) {
    sum += stat.statValue!;
  }
  return sum ~/ 6;
}

//Merges multiple Types into one String
String getTypesFromTypesClass(List<Types> types) {
  List<String> stringList = [];

  for (var type in types) {
    stringList.add(type.typeName!.toCapitalized());
  }

  return stringList.join(', ').toString();
}

//Removes (-) from the Pokemon and Stats names as well as capitalizes the first letter
String parseName(String name) {
  String initialName = name.replaceAll('-', ' ').toTitleCase().toString();
  return initialName;
}

double calulcateBMI(PokemonModel pokemonModel) {
  return ((pokemonModel.weight!) / (pokemonModel.height! * pokemonModel.height!)).roundToDouble();
}
