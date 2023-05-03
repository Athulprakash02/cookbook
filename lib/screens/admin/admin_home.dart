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
  late Recipes categories;
  final _searchController = TextEditingController();

  // var categoryItem = [
  //   'Breakfast',
  //   'Lunch',
  //   'Dinner',
  //   'Indian',
  //   'Italian',
  //   'Arabian',
  //   'Chinese'
  // ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllRecipe();
  }

  @override
  Widget build(BuildContext context) {
    recipeList = Hive.box('recipe_list');
    final items = recipeList.values.toList();
    final categories = items.map((recipe) => recipe.catogory).toSet().toList();

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
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
          title: const Text('Recipes'),
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
                      controller: _searchController,
                      decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.search),
                          hintText: 'Search Recipes',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 2,
                ),
                TabBar(
                  isScrollable: true,
                  labelColor: const Color.fromARGB(255, 0, 0, 0),
                  unselectedLabelColor: Colors.cyan,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      color: Colors.cyan.shade300),
                  tabs: categories
                      .map((category) => Tab(text: category))
                      .toList(),
                ),
                const Divider(
                  thickness: 2,
                  // height: 2,
                ),
                Expanded(
                  child: TabBarView(
                    children: categories.map(
                      (category) {
                        return ValueListenableBuilder(
                            valueListenable: recipeListNotifier,
                            builder: (context, List<Recipes> items, child) {
                              List<Recipes> categoryRecipes = items
                                  .where((item) => item.catogory == category)
                                  .toList();
                              return ListView.builder(
                                itemBuilder: (context, index) {
                                  final data = categoryRecipes[index];
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => RecipeScreen(
                                              passValue: data, idPass: index),
                                        ));
                                      },
                                      child: viewCard(context, data, index));
                                },
                                itemCount: categoryRecipes.length,
                              );
                            });
                      },
                    ).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
