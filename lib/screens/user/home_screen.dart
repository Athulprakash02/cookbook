import 'package:cookbook/db/functions/db_recipe_functions.dart';
import 'package:cookbook/db/functions/login_functions.dart';
import 'package:cookbook/db/model/login_model.dart';
import 'package:cookbook/db/model/recipies.dart';
import 'package:cookbook/screens/managing/add_screen.dart';
import 'package:cookbook/screens/managing/manage_screen.dart';
import 'package:cookbook/screens/user/favourites_screen.dart';
import 'package:cookbook/screens/user/recent_screen.dart';
import 'package:cookbook/screens/user/search_screen.dart';
import 'package:cookbook/widgets/about_us.dart';
import 'package:cookbook/widgets/build_recipe_list.dart';
import 'package:cookbook/widgets/terms_and_conditions.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late LoginData userLogged;

  // late LoginData user;
  late Box<Recipes> recipeList;
  // late int _selectedOption;

  // final _search = TextEditingController();
  var categoryItem = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Indian',
    'Italian',
    'Arabian',
    'Chinese'
  ];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    // print('kitti $user');
    // loggedUserInfo();

    getAllRecipe();
  }

  @override
  Widget build(BuildContext context) {
    // final userName = getUserName();

    return ValueListenableBuilder(
      valueListenable: recipeListNotifier,
      builder: (context, value, child) {
        recipeList = Hive.box<Recipes>('recipe_list');
        final items = recipeList.values.toList();
        final categories =
            items.map((recipe) => recipe.catogory).toSet().toList();

        return DefaultTabController(
          length: categories.length,
          child: Scaffold(
            // backgroundColor: const Color.fromARGB(234, 255, 255, 255),
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SearchScreen(),
                      ));
                    },
                    icon: const Icon(Icons.search_outlined)),
              ],
              // backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              elevation: 0,
              title: const Text(
                'CookBook',
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
                  const Center(
                    child: DrawerHeader(
                      child: Padding(
                        padding: EdgeInsets.all(35.0),
                        child: Text(
                          'userName',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const FavouritesScreen(),
                              ));
                            },
                            icon: const Icon(
                              Icons.favorite_border,
                              color: Colors.black,
                            ),
                            label: const Text(
                              'Favourite recipes',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            )),
                        TextButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const RecentsScreen(),
                              ));
                            },
                            icon: const Icon(
                              Icons.history,
                              color: Colors.black,
                            ),
                            label: const Text(
                              'Recently Viewed',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            )),
                        TextButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ManageScreen(),
                              ));
                            },
                            icon: const Icon(
                              Icons.food_bank_outlined,
                              color: Colors.black,
                            ),
                            label: const Text(
                              'Manage recipes',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            )),
                        TextButton.icon(
                            onPressed: () {
                              termsAndConditions(context);
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: (context) =>
                              //       const TermsAndConditions(),
                              // ));
                            },
                            icon: const Icon(
                              Icons.list_alt,
                              color: Colors.black,
                            ),
                            label: const Text(
                              'Terms and Conditions',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            )),
                        TextButton.icon(
                            onPressed: () {
                              aboutUs(context);
                              
                            },
                            icon: const Icon(
                              Icons.info_outline,
                              color: Colors.black,
                            ),
                            label: const Text(
                              'About Us',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
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
                    const SizedBox(
                      height: 10,
                    ),
                    Theme(
                      data: ThemeData(),
                      child: TabBar(
                        isScrollable: true,
                        physics: const BouncingScrollPhysics(),
                        labelColor: const Color.fromARGB(255, 0, 0, 0),
                        unselectedLabelColor: Colors.cyan,
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.black,
                        indicator: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            color: Colors.cyan.shade300),
                        tabs: categories
                            .map((category) => Tab(
                                  child: Text(
                                    category,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                      // height: 2,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: recipeList.isEmpty
                            ? const Center(
                                child: Text(
                                'Please add some Recipes',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ))
                            : TabBarView(
                                children: categories.map(
                                  (category) {
                                    return buildCategoryRecipeList(
                                        items, category);
                                    //
                                  },
                                ).toList(),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AddScreen(),
                ));
              },
              child: const Icon(
                Icons.add,
                size: 35,
                color: Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }
}
