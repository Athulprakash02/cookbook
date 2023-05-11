import 'package:cookbook/db/functions/db_recipe_functions.dart';
import 'package:cookbook/db/model/recipies.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

ValueNotifier<List<Recipes>> favouriteNotifier = ValueNotifier([]);

final box = Hive.box<Recipes>('favourites_list');
Future<void> addToFavourite(Recipes favourited) async {
  Recipes recipe = Recipes(
      imagePath: favourited.imagePath,
      recipeName: favourited.recipeName,
      cookingTime: favourited.cookingTime,
      catogory: favourited.catogory,
      ingredients: favourited.ingredients,
      extraIngredients: favourited.extraIngredients,
      directions: favourited.directions,
      url: favourited.url);
  // int index=0;
  box.put(recipe.recipeName, recipe);
  // favouriteNotifier.value.add(recipe);
  recipeListNotifier.notifyListeners();
  print('Added');
  print(favourited.recipeName);
  
}



Future<void> removeFavorite(String recipename) async {
  print(recipename);
  await box.delete(recipename);
  recipeListNotifier.notifyListeners();
  print('deleted');
  print('box');
 
}


Future<void> getAllFavourites() async {
  final recipeDB = await Hive.openBox<Recipes>('favourites_list');
  recipeListNotifier.value.clear();
  for (var std in recipeDB.values) {
    recipeListNotifier.value.add(std);
  }
  recipeListNotifier.notifyListeners();
}


// bool checkFavorite(Recipes data){
//   final isFavourite = box.get(data.recipeName) != null;
//   print('object $isFavourite');
// }