import 'package:cookbook/db/functions/db_recipe_functions.dart';
import 'package:cookbook/db/model/recipies.dart';
import 'package:cookbook/screens/managing/add_screen.dart';


import 'package:cookbook/screens/user/recipe_screen.dart';
import 'package:cookbook/widgets/card.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ManageScreen extends StatefulWidget {
  const ManageScreen({super.key});

  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
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
   

    return Scaffold(
      appBar: AppBar(
        
        // backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        title: const Text('CookBook'),
        centerTitle: true,
        actions: [
           IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddScreen(),
              ));
            },
            icon: const Icon(
              Icons.add_box_outlined,
              size: 30,
            )),
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
                    // focusNode: FocusScopeNode(),
                    // autofocus: false,
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
                builder: (ctx, List<Recipes> recipeData, child) {
                  // recipeData=recipeList;
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: recipeData.length,
                    itemBuilder: (ctx, index) {
                      final data = recipeData[index];
                      return GestureDetector(
                        onTap: () async {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }

                          await Future.delayed(const Duration(milliseconds: 300));
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
