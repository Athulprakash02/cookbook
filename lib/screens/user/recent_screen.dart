import 'package:cookbook/db/model/recipies.dart';
import 'package:cookbook/widgets/recent_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RecentsScreen extends StatefulWidget {
  const RecentsScreen({super.key});

  @override
  State<RecentsScreen> createState() => _RecentsScreenState();
}

class _RecentsScreenState extends State<RecentsScreen> {

//  final box = Hive.openBox<Recipes>('recently_viewed');
 final items = Hive.box<Recipes>('recently_viewed').values.toList();
 late List<Recipes> recentRecipes = List<Recipes>.from(items).toSet().toList(); 
//  late List<Recipes> recentlyVisited = List<Recipes>.from(bo);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Recently viewed'),
        centerTitle: true,
      ),
      body: SafeArea(child: ListView.builder(itemBuilder: (context, index) {
        return recentCard(recentRecipes[index]);
      },itemCount: recentRecipes.length,),),

    );
  }
}