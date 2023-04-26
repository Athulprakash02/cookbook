import 'package:cookbook/db/model/recipies.dart';
import 'package:flutter/foundation.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


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

// Future<void> launchURL(String url) async{
//   final Uri _url = Uri(scheme: "https",host: url);
//  if(!await launchUrl(_url,mode: LaunchMode.externalApplication)){

//  } else{
//   throw 'Could not Launch Youtube';
//  }
// }

Future<void> launchURL(url) async {
  final Uri _url = Uri.parse(url);
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
Future<void> getAllRecipe() async{
  final recipeDB = await Hive.openBox<Recipes>('recipe_list');
  recipeListNotifier.value.clear();
  for(var std in recipeDB.values){
   recipeListNotifier.value.add(std);

  }
  recipeListNotifier.notifyListeners();
}