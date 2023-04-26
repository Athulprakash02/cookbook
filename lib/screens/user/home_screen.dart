import 'package:cookbook/db/functions/db_recipe_functions.dart';
import 'package:cookbook/db/functions/login_functions.dart';
import 'package:cookbook/db/model/recipies.dart';
import 'package:cookbook/screens/recipe_screen.dart';

import 'package:cookbook/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box recipeList;
  late int _selectedOption;
  final _search = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllRecipe();
    recipeList = Hive.box<Recipes>('recipe_list');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        // backgroundColor: const Color.fromARGB(234, 255, 255, 255),
        appBar: AppBar(
          actions: [
            
            PopupMenuButton(
              onSelected: (value) {
                setState(() {
                  _selectedOption = value;
                });
              },
              itemBuilder: (context) {
              return [
                const PopupMenuItem(value: 1,child: Text('sort by name'),),
                const PopupMenuItem(value: 2,child: Text('sort by duration(less to more)'),),
                const PopupMenuItem(value: 3,child: Text('sort by time'),),
              ];
            },
            tooltip: 'sort',)
          ],
          // backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
          title: const Text(
            'Recipes',
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
        ),

        //Drawer
        drawer: Drawer(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50))),
          child: ListView(
            children: [
              DrawerHeader(
                child: Row(
                  children: const [
                    DrawerHeader(
                        child: CircleAvatar(
                      radius: 38,
                      backgroundImage: AssetImage('assets/images/prof.jpg'),
                    )),
                    Text(
                      'UserName',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                        ),
                        label: const Text(
                          'Saved recipes',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        )),
                    TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.history,
                          color: Colors.black,
                        ),
                        label: const Text(
                          'Recently Viewed',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        )),
                    TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.black,
                        ),
                        label: const Text(
                          'Settings',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        )),
                    TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.info_outline,
                          color: Colors.black,
                        ),
                        label: const Text(
                          'About',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        )),
                    TextButton.icon(
                        onPressed: () {
                         confirmation(context);
                              
                        },
                        icon: const Icon(
                          Icons.logout_rounded,
                          color: Colors.black,
                        ),
                        label: const Text(
                          'Logout',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),

        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 25, 30, 10),
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                suffixIcon: const Icon(Icons.search),
                                hintText: 'Search Recipes',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                          
                        ),
                        const SizedBox(width: 5,),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.cyan.shade300

                          ),
                          child: IconButton(
                            
                            onPressed: () {
                            
                          }, icon: const Icon(Icons.filter_alt)),
                          
                        )
                      ],
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
                        color: Colors.cyan.shade300),
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
                                  child: userCard(data));
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
                                  child: userCard(data));
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
                                  child: userCard(data));
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
                                  child: userCard(data));
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
}
