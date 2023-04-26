import 'package:cookbook/db/functions/db_recipe_functions.dart';
import 'package:cookbook/db/model/recipies.dart';
import 'package:cookbook/screens/admin/add_screen.dart';
import 'package:cookbook/screens/user/login_screen.dart';
import 'package:cookbook/screens/recipe_screen.dart';
import 'package:cookbook/widgets/card.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  late Box<Recipes> recipeList;
  final _search = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllRecipe();
    recipeList = Hive.box('recipe_list');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
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
                    labelColor: const Color.fromARGB(255, 0, 0, 0),
                    unselectedLabelColor: Colors.cyan,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        color:Colors.cyan.shade300),
                    tabs: const [
                      Tab(
                        child: Text(
                          'All',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Breakfast',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Lunch',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Dinner',
                          style: TextStyle(fontSize: 15),
                        ),
                      )
                    ]),
                const Divider(
                  thickness: 2,
                  height: 2,
                ),
                Expanded(
                    child: TabBarView(children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ValueListenableBuilder(
                        valueListenable: recipeListNotifier,
                        builder: (BuildContext context,
                            List<Recipes> recipeData, Widget? child) {
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              final data = recipeData[index];
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => RecipeScreen(passValue: data, idPass: index),
                                    ));
                                  },
                                  child: viewCard(data));
                            },
                            itemCount: recipeData.length,
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ValueListenableBuilder(
                        valueListenable: recipeListNotifier,
                        builder: (BuildContext context,
                            List<Recipes> recipeData, Widget? child) {
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              final data = recipeData[index];
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => RecipeScreen(passValue: data, idPass: index),
                                    ));
                                  },
                                  child: viewCard(data));
                            },
                            itemCount: recipeData.length,
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ValueListenableBuilder(
                        valueListenable: recipeListNotifier,
                        builder: (BuildContext context,
                            List<Recipes> recipeData, Widget? child) {
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              final data = recipeData[index];
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => RecipeScreen(passValue: data, idPass: index),
                                    ));
                                  },
                                  child: viewCard(data));
                            },
                            itemCount: recipeData.length,
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ValueListenableBuilder(
                        valueListenable: recipeListNotifier,
                        builder: (BuildContext context,
                            List<Recipes> recipeData, Widget? child) {
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              final data = recipeData[index];
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => RecipeScreen(passValue: data, idPass: index),
                                    ));
                                  },
                                  child: viewCard(data));
                            },
                            itemCount: recipeData.length,
                          );
                        }),
                  ),
                ])),
              ],
            ),
          ),
        ),
      ),
    );
  }

  signout(BuildContext ctx) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.clear();
    // ignore: use_build_context_synchronously
    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (route) => false);
  }

  confirmation(BuildContext context) async {
    return showDialog(
      
      context: context,
      builder: (ctx1) {
        return AlertDialog(
          backgroundColor: Colors.grey,
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text(
              style: TextStyle(
                color: Color.fromARGB(255, 5, 5, 5),
                fontSize: 36,
              ),
              'Log out'),
          content: const Text('You will be returned to login screen'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx1).pop();
              },
              child: const Text(
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                  'Cancel'),
            ),
            TextButton(
              onPressed: () => signout(context),
              child: const Text(
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                  'Log out'),
            ),
          ],
        );
      },
    );
  }
}
