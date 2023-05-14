
import 'package:cookbook/db/functions/db_functions.dart';
import 'package:cookbook/db/functions/db_recipe_functions.dart';
import 'package:cookbook/db/functions/login_functions.dart';
import 'package:cookbook/db/model/login_model.dart';
import 'package:cookbook/db/model/recipies.dart';
import 'package:cookbook/main.dart';
import 'package:cookbook/screens/managing/manage_screen.dart';
import 'package:cookbook/screens/splash_screen.dart';
import 'package:cookbook/screens/user/favourites_screen.dart';
import 'package:cookbook/screens/user/recent_screen.dart';
import 'package:cookbook/screens/user/search_screen.dart';
import 'package:cookbook/widgets/build_recipe_list.dart';


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
  late int _selectedOption;

  final _search = TextEditingController();
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
  
    getAllRecipe();

    
   
  }
  
  @override
  Widget build(BuildContext context) {
    recipeList = Hive.box<Recipes>('recipe_list');
    final items = recipeList.values.toList();
    final categories = items.map((recipe) => recipe.catogory).toSet().toList();
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        // backgroundColor: const Color.fromARGB(234, 255, 255, 255),
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SearchScreen(),));
            }, icon: const Icon(Icons.search_outlined)),
           
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
              Center(
                child: DrawerHeader(
                  child: Text(
                  user ?? 'user',
                    style: const TextStyle(fontSize: 20),
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
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FavouritesScreen(),));
                        },
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                        ),
                        label: const Text(
                          'Favourite recipes',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        )),
                    TextButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RecentsScreen(),));
                        },
                        icon: const Icon(
                          Icons.history,
                          color: Colors.black,
                        ),
                        label: const Text(
                          'Recently Viewed',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        )),
                    TextButton.icon(
                        onPressed: () {
                           Navigator.of(context).push(MaterialPageRoute(builder: (context) => ManageScreen(),));
                        },
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.black,
                        ),
                        label: const Text(
                          'Manage recipes',
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
                
                const SizedBox(height: 10,),
                Theme(
                  data: ThemeData(
                   
                  ),
                  child: TabBar(
                    isScrollable: true,
                   
                    physics: const BouncingScrollPhysics(),
                    labelColor: const Color.fromARGB(255, 0, 0, 0),
                    unselectedLabelColor: Colors.cyan,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.black,
                    indicator: BoxDecoration(
                      
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        color: Colors.cyan.shade300),
                    tabs: categories
                        .map((category) => Tab(child: Text(category,style: const TextStyle(fontSize: 18),),))
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
                    child: TabBarView(
                      children: categories.map(
                        (category) {
                          return buildCategoryRecipeList(items, category);
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
      ),
    );
  }

  
}
