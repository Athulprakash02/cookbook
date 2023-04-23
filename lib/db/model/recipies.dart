import 'package:hive/hive.dart';

@HiveType(typeId: 2)
class Recipes extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String imagePath;

  @HiveField(2)
  final String recipeName;

  @HiveField(3)
  final String cookingTime;

  @HiveField(4)
  final String catogory;

  @HiveField(5)
  final String ingredients;

  @HiveField(6)
  final String directions;

  Recipes(
      {required this.imagePath,
      required this.recipeName,
      required this.cookingTime,
      required this.catogory,
      required this.ingredients,
      required this.directions});
}
