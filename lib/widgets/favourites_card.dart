
import 'dart:io';

import 'package:cookbook/db/functions/favourite_function.dart';
import 'package:cookbook/db/model/recipies.dart';
import 'package:cookbook/screens/recipe_screen.dart';
import 'package:flutter/material.dart';

Widget favouritesCard(Recipes recipe,BuildContext ctx,int index){
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
    child: ListTile(
      onTap: () {
        Navigator.of(ctx).push(MaterialPageRoute(builder: (context) => RecipeScreen(passValue: recipe, idPass: index),));
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      tileColor: Colors.grey.shade200,
      horizontalTitleGap: 20,
      minVerticalPadding: 10,
      leading: Container(
        width: 80,
        height: 120,
        // color: Colors.red,
        decoration: BoxDecoration(
          
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(image: FileImage(File(recipe.imagePath)),fit: BoxFit.cover),

        ),
      ),
      title:  Text(recipe.recipeName,style: const TextStyle(fontSize: 20),),
      subtitle: Text(recipe.catogory),
      trailing:IconButton(onPressed: () {
        removeFavorite(recipe.recipeName);
        getAllFavourites();
      }, icon:  const Icon(Icons.highlight_remove_rounded,size: 35,color: Colors.red,)),
  
    ),
  );
}