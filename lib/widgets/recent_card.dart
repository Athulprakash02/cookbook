import 'package:cookbook/db/model/recipies.dart';
import 'package:flutter/material.dart';

Widget recentCard(Recipes recipe){
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
    child: ListTile(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      tileColor: Colors.grey.shade200,
      horizontalTitleGap: 20,
      minVerticalPadding: 25,
      leading: Container(
        width: 80,
        height: 100,
        // color: Colors.red,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(15)

        ),
      ),
      title:  Text(recipe.recipeName,style: TextStyle(fontSize: 20),),
      
  
    ),
  );
}