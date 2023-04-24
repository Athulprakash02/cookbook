import 'package:cookbook/db/model/login_model.dart';
import 'package:cookbook/db/model/recipies.dart';
import 'package:cookbook/screens/splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';



const SAVE_KEY_NAME = 'adminLoggedIn';
const adminMail = 'admin@gmail.com';
const adminPass = '0000';
void main(List<String> args) async{
  // debugPaintSizeEnabled = true;
  await Hive.initFlutter();
  

  if(!Hive.isAdapterRegistered(LoginDataAdapter().typeId)){
    Hive.registerAdapter(LoginDataAdapter());
  }
  if(!Hive.isAdapterRegistered(RecipesAdapter().typeId)){
    Hive.registerAdapter(RecipesAdapter());
  }
 await Hive.openBox<Recipes>('recipe_list');
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CookBook',
      theme: ThemeData(
       primarySwatch: Colors.grey
      ),  
      home: const ScreenSplash(),
      debugShowCheckedModeBanner: false,
    );
  }
}