import 'package:hive/hive.dart';
import 'package:pokedex_app/models/hive_poke_model.dart';
import 'package:pokedex_app/utilities/consts.dart';

class HiveService {
  static Box<HivePokeModel> getSavedPokemonsFromHive() => Hive.box<HivePokeModel>(Constants.hiveBoxName);

  static Future addToPokemonHiveDatabase({required String name, required int id}) async {
    final model = HivePokeModel()
      ..name = name
      ..id = id
      ..dateAdded = DateTime.now();

    final box = HiveService.getSavedPokemonsFromHive();
    await box.put(id.toString(), model);
  }

  static Future removePokemonFromHiveDatabase(int pokemonId) async {
    final box = HiveService.getSavedPokemonsFromHive();
    await box.delete(pokemonId.toString());
  }

  static List<HivePokeModel> getInitialPokemonAndPaginated({int skip = 0}) {
    final box = HiveService.getSavedPokemonsFromHive();
    final pokemonFromHive = box.values.toList().cast<HivePokeModel>();

    pokemonFromHive.sort((b, a) => a.dateAdded.compareTo(b.dateAdded));
    final finalPokemons = pokemonFromHive.skip(skip).take(15).toList();

    return finalPokemons;
  }
}
