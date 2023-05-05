import 'package:cookbook/db/functions/db_recipe_functions.dart';
import 'package:cookbook/db/functions/login_functions.dart';
import 'package:cookbook/db/model/recipies.dart';
import 'package:cookbook/screens/admin/add_screen.dart';

import 'package:cookbook/screens/recipe_screen.dart';
import 'package:cookbook/widgets/card.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  late Box<Recipes> recipeList;

  final _searchController = TextEditingController();
  List<Recipes> recipeData = Hive.box<Recipes>('recipe_list').values.toList();
  late List<Recipes> recipes = List<Recipes>.from(recipeData);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllRecipe();
  }

  @override
  Widget build(BuildContext context) {
    // recipeList = Hive.box('recipe_list');
    // final items = recipeList.values.toList();
    // final categories = items.map((recipe) => recipe.catogory).toSet().toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddScreen(),
              ));
            },
            icon: const Icon(
              Icons.add_box_outlined,
              size: 30,
            )),
        // backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        title: const Text('CookBook'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                confirmation(context);
              },
              icon: const Icon(
                Icons.logout_outlined,
                size: 30,
              ))
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 25, 30, 10),
                child: SizedBox(
                  height: 50,
                  child: TextFormField(
                    autofocus: false,
                    controller: _searchController,
                    decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.search),
                        hintText: 'Search Recipes',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onChanged: (value) {
                      _recipeSearch(value);
                    },
                  ),
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              const Text(
                'Food Recipes',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const Divider(
                thickness: 2,
                
              ),
              Expanded(
                  child: ValueListenableBuilder(
                valueListenable: recipeListNotifier,
                builder: (ctx, List<Recipes> recipeList, child) {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: recipes.length,
                    itemBuilder: (ctx, index) {
                      final data = recipes[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                RecipeScreen(passValue: data, idPass: index),
                          ));
                        },
                        child: viewCard(ctx, data, index),
                      );
                    },
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }

  void _recipeSearch(String recipeName) {
    setState(() {
      recipes = recipeData
          .where((element) => element.recipeName
              .toLowerCase()
              .contains(recipeName.toLowerCase()))
          .toList();
    });
  }
}
