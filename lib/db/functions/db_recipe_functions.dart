import 'package:cookbook/db/model/recipies.dart';
import 'package:flutter/foundation.dart';

import 'package:hive_flutter/hive_flutter.dart';

ValueNotifier<List<Recipes>> recipeListNotifier = ValueNotifier([]);

Future<void> uploadRecipe(Recipes value) async{
  print('haii');
  final upload = await Hive.openBox<Recipes>('recipe_list');
  final _details = await upload.add(value);
  value.id = _details;
  getAllRecipe();
  recipeListNotifier.value.add(value);
  recipeListNotifier.notifyListeners();
  
  
}  

Future<void> getAllRecipe() async{
  final recipeDB = await Hive.openBox<Recipes>('recipe_list');
  recipeListNotifier.value.clear();
  for(var std in recipeDB.values){
   recipeListNotifier.value.add(std);

  }
  recipeListNotifier.notifyListeners();
}