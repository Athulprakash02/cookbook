import 'package:cookbook/db/functions/db_recipe_functions.dart';
import 'package:cookbook/db/model/recipies.dart';
import 'package:hive_flutter/hive_flutter.dart';


Future<void> recentlyViewed(Recipes passvalue) async {
    print('entered recenlyviewed');
    final box = await Hive.openBox<Recipes>('recently_viewed');
    Recipes recipe = Recipes(
        imagePath: passvalue.imagePath,
        recipeName: passvalue.recipeName,
        cookingTime: passvalue.cookingTime,
        catogory: passvalue.catogory,
        ingredients: passvalue.ingredients,
        extraIngredients: passvalue.extraIngredients,
        directions: passvalue.directions,
        url: passvalue.url);
   
    int index=0;
    for (var element in box.values) {
      if (recipe.recipeName == element.recipeName) {
        box.deleteAt(index);
        box.add(recipe);
        break;

       
      }
      index++;
    }
     box.add(recipe);
    recents();
  }
List <Recipes>recently = [];

Future recents() async{
 
  print(' entered recents');
  final box =await Hive.openBox<Recipes>('recently_viewed');
  List<Recipes> recentlyViewedList = box.values.toList();
recently = recentlyViewedList.reversed.toList();
// recently.clear();
 
}

Future<void> getAllRecents() async {
  final recipeDB = await Hive.openBox<Recipes>('favourites_list');
  
  // recipeListNotifier.value.clear();
  for (var std in recipeDB.values) {
    // recipeListNotifier.value.add(std);
  }
  // recipeListNotifier.notifyListeners();
}

