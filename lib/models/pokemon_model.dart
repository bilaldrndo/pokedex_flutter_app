class PokemonModel {
  int? id;
  String? name;
  String? imageUrl;
  List<Stats>? stats;
  List<Types>? types;
  int? weight;
  int? height;

  PokemonModel({
    this.id,
    this.name,
    this.imageUrl,
    this.stats,
    this.types,
    this.weight,
    this.height,
  });

  PokemonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['sprites']['other']['official-artwork']['front_default'];
    if (json['stats'] != null) {
      stats = <Stats>[];
      json['stats'].forEach((v) {
        stats!.add(Stats.fromJson(v));
      });
    }
    if (json['types'] != null) {
      types = <Types>[];
      json['types'].forEach((v) {
        types!.add(Types.fromJson(v));
      });
    }
    weight = json['weight'];
    height = json['height'];
  }
}

class Stats {
  int? statValue;
  String? statName;

  Stats({
    this.statValue,
    this.statName,
  });

  Stats.fromJson(Map<String, dynamic> json) {
    statValue = json['base_stat'];
    statName = json['stat']['name'];
  }
}

class Types {
  String? typeName;

  Types({
    this.typeName,
  });

  Types.fromJson(Map<String, dynamic> json) {
    typeName = json['type']['name'];
  }
}
