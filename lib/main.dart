// import 'package:cookbook/bloc/bloc/add_recipe_bloc.dart';
import 'package:cookbook/bloc/add_fav_bloc/bloc/add_favourite_bloc.dart';
import 'package:cookbook/bloc/comment_Screen_bloc/bloc/comment_screen_bloc.dart';
import 'package:cookbook/bloc/fav_screen_bloc/bloc/favourite_screen_bloc.dart';
import 'package:cookbook/bloc/home_screen_bloc/bloc/home_bloc.dart';
import 'package:cookbook/bloc/image/bloc/image_bloc.dart';
import 'package:cookbook/bloc/ingredients_add_bloc/bloc/add_textfeild_bloc.dart';
import 'package:cookbook/bloc/recent_screen_bloc/bloc/recent_screen_bloc.dart';
import 'package:cookbook/bloc/search_screen_bloc/bloc/search_bloc.dart';
import 'package:cookbook/bloc/update_image_bloc/bloc/update_image_bloc.dart';
import 'package:cookbook/db/model/comments_db.dart';
import 'package:cookbook/db/model/login_model.dart';
import 'package:cookbook/db/model/recipies.dart';
import 'package:cookbook/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_flutter/hive_flutter.dart';

const SAVE_KEY_NAME = 'adminLoggedIn';

const userLoggedIn = 'userLogged';
// const USER_NAME_KEY = 'name';
// String  user = 'User';
//  String? emailLoggedIn;
// String? user;
// late LoginData user;

void main(List<String> args) async {
  // debugPaintSizeEnabled = true;
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(LoginDataAdapter().typeId)) {
    Hive.registerAdapter(LoginDataAdapter());
  }
  if (!Hive.isAdapterRegistered(RecipesAdapter().typeId)) {
    Hive.registerAdapter(RecipesAdapter());
  }
  if (!Hive.isAdapterRegistered(CommentsDataAdapter().typeId)) {
    Hive.registerAdapter(CommentsDataAdapter());
  }
  await Hive.openBox<Recipes>('recipe_list');
  await Hive.openBox<CommentsData>('comments_db');
  await Hive.openBox<Recipes>('recently_viewed');
  await Hive.openBox<Recipes>('favourites_list');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => ImageBloc(),
        ),
        BlocProvider(
          create: (context) => AddTextfeildBloc(),
        ),
        BlocProvider(
          create: (context) => AddFavouriteBloc(),
        ),
        BlocProvider(
          create: (context) => FavouriteScreenBloc(),
        ),
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
        BlocProvider(
          create: (context) => RecentScreenBloc(),
        ),
        BlocProvider(
          create: (context) => CommentScreenBloc(),
        ),
        BlocProvider(
          create: (context) => UpdateImageBloc(),
        )
      ],
      child: MaterialApp(
        title: 'CookBook',
        theme: ThemeData(primarySwatch: Colors.cyan),
        home: const ScreenSplash(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
