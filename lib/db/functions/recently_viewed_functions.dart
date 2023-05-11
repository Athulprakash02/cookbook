import 'package:cookbook/db/model/recipies.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Future<void> recentlyViewed (Recipes passValue) async{
//    print('entered recenlyviewed');
//     final box = await Hive.openBox<Recipes>('recently_viewed');
//     await box.add(passValue);
    

//     //   final item =widget.passValue;
//     // print('name: ${item.recipeName}');
//     // final timestamp = DateTime.now();
//     // final key = timestamp.toString();
//     recents();
    
    
// }

Future<void> recents() async{
  print(' entered recents');
  final box =await Hive.openBox<Recipes>('recently_viewed');
  List<Recipes> recentlyViewedList = box.values.toList();

 for(var recipe in recentlyViewedList){
  print(recipe.recipeName);
 }

}