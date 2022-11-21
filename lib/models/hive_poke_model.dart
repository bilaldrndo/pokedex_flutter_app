import 'package:hive/hive.dart';

part 'hive_poke_model.g.dart';

@HiveType(typeId: 0)
class HivePokeModel extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late int id;

  @HiveField(2)
  late DateTime dateAdded;
}
