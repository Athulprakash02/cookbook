import 'package:cookbook/db/model/recipies.dart';

import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

List<Recipes> recipeList = [];

Future<void> addRecipe(Recipes value) async {
  print('haii');
  final upload = await Hive.openBox<Recipes>('recipe_list');
  final _details = await upload.add(value);
  value.id = _details;
  getAllRecipe();
  // recipeListNotifier.value.add(value);
  // recipeListNotifier.notifyListeners();
}


Future<void> launchURL(url) async {
  final Uri _url = Uri.parse(url);
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}

Future<void> getAllRecipe() async {
  final recipeDB = await Hive.openBox<Recipes>('recipe_list');
  // recipeListNotifier.value.clear();
  for (var std in recipeDB.values) {
    // recipeListNotifier.value.add(std);
  }
  // recipeListNotifier.notifyListeners();
}

deleteAlert(BuildContext context, key) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      content: const Text(
        'Delete recipe?',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      actions: [
        TextButton(
            onPressed: () {
              deleteRecipe(key);
              Navigator.of(ctx).pop();
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red, fontSize: 20),
            )),
        TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 20, color: Colors.green),
            ))
      ],
    ),
  );
}


Future<void> deleteRecipe(int id) async{
  final recipeDB = await Hive.openBox<Recipes>('recipe_list');

  await recipeDB.delete(id);
  getAllRecipe();
  // recipeListNotifier.notifyListeners();
}


 