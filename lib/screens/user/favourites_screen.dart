import 'package:cookbook/db/functions/favourite_function.dart';
import 'package:cookbook/db/model/recipies.dart';
import 'package:cookbook/widgets/favourites_card.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllFavourites();
  }
  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Recipes>('favourites_list');
    List<Recipes> favourites = box.values.toList();
    
    return   Scaffold(
      appBar: AppBar(
        title: const Text('Favourited recipes'),
        centerTitle: true,
      ),
      body: SafeArea(child: ListView.builder(
       physics: const BouncingScrollPhysics(),
       itemBuilder: (context, index) {
       return favouritesCard(favourites[index], context, index);
        },itemCount: favourites.length,),),

    );
  }
}