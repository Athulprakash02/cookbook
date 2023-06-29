import 'package:cookbook/db/model/recipies.dart';
import 'package:cookbook/screens/user/recipe_screen.dart';
import 'package:cookbook/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // late int _selectedOption;
  final _searchController = TextEditingController();

  List<Recipes> recipeList = Hive.box<Recipes>('recipe_list').values.toList();
  late List<Recipes> recipes = List<Recipes>.from(recipeList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        autofocus: true,
                        controller: _searchController,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  clearText();
                                },
                                icon: const Icon(Icons.clear)),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            hintText: 'Search Recipe...'),
                        onChanged: (value) {
                          _recipeSearch(value);
                        },
                      ),
                    ),
                    // IconButton(
                    //   onPressed: () {
                    //     print('object');
                    //   },
                    //   icon: const Icon(Icons.filter_alt_outlined),
                    //   iconSize: 35,
                    // )
                  ],
                ),
              ),
              Expanded(
                  child: recipes.isNotEmpty
                      ? ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: recipes.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);

                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => RecipeScreen(
                                        passValue: recipes[index],
                                        idPass: index),
                                  ));
                                },
                                child: userCard(recipes[index]));
                          },
                        )
                      : const Center(
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
          .where((element) =>
              element.recipeName
                  .toLowerCase()
                  .contains(recipeName.toLowerCase()) ||
              element.catogory.toLowerCase().contains(recipeName.toLowerCase()))
          .toList();
    });
  }

  void clearText() {
    _searchController.clear();
  }
}
