import 'dart:io';

import 'package:cookbook/db/model/recipies.dart';
import 'package:cookbook/screens/recipe_screen.dart';
import 'package:cookbook/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  List<Recipes> recipeList = Hive.box<Recipes>('recipe_list').values.toList();
  late List<Recipes> recipes = List<Recipes>.from(recipeList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.cyan),
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                controller: _searchController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon:
                        IconButton(onPressed: () {
                          clearText();
                        }, icon: Icon(Icons.clear)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: 'Search Recipe...'),
                onChanged: (value) {
                  _recipeSearch(value);
                },
              ),
              Expanded(
                  child: recipes.isNotEmpty
                      ? ListView.builder(
                        itemCount: recipes.length,
                          itemBuilder: (context, index) {
                            // File image = File(recipes[index].imagePath);
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => RecipeScreen(passValue: recipes[index], idPass: index),));
                              },
                              child: userCard(recipes[index]));
                          },
                        )
                      : Center(
                          child: Text("Couldn't find results"),
                        ))
            ],
          ),
        )),
      ),
    );
  }

  void _recipeSearch(String recipeName) {
    setState(() {
      recipes = recipeList
          .where((element) => element.recipeName
              .toLowerCase()
              .contains(recipeName.toLowerCase()))
          .toList();
    });
  }

  void clearText(){
    _searchController.clear();
  }
}
