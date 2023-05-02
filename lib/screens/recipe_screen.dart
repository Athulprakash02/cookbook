import 'dart:io';

import 'package:cookbook/db/functions/db_recipe_functions.dart';
import 'package:cookbook/db/model/recipies.dart';
import 'package:cookbook/screens/user/review_screen.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeScreen extends StatefulWidget {
  RecipeScreen({Key? key,
  required this.passValue,
  required this.idPass
  }) : super(key: key);


  Recipes passValue;
  final int idPass;

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  List<String> ingredientsList= [];

  @override
  Widget build(BuildContext context) {
    
    ingredientsList.add(widget.passValue.ingredients);
    ingredientsList.addAll(widget.passValue.extraIngredients);
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: double.maxFinite,
                  height: 350,
                  decoration:  BoxDecoration(
                      image: DecorationImage(
                          image:
                              FileImage(File(widget.passValue.imagePath)),
                          fit: BoxFit.cover)),
                )),
            Positioned(
                top: 30,
                left: 20,
                child: CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 234, 201, 198),
                  radius: 25,
                  child: IconButton(
                      iconSize: 35,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back_sharp)),
                )),
            Positioned(
                top: 30,
                right: 20,
                child: CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 234, 201, 198),
                  radius: 25,
                  child: IconButton(
                      iconSize: 30,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ReviewScreen(),
                        ));
                      },
                      icon: const Icon(Icons.reviews_outlined)),
                )),
                 Positioned(
                top: 90,
                right: 20,
                child: CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 234, 201, 198),
                  radius: 25,
                  child: IconButton(
                      iconSize: 35,
                      onPressed: () {
                        launchURL
                           (widget.passValue.url);
                        // await launch
                        // await LaunchApp.openApp(
                        //   androidPackageName: "${widget.passValue.url}com.google.youtube"
                        // );
                      //  launchURL(widget.passValue.url);

                      },
                      icon: const Icon(Icons.play_circle_fill,color: Colors.red,)),
                )),
            Positioned(
                top: 320,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.65,
                  // height: 500,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 244, 208, 208),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                    child: Column(
                      children: [
                         Text(
                          widget.passValue.recipeName,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children:  [
                            const Icon(Icons.watch_later_outlined),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(widget.passValue.cookingTime)
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 236, 227, 227),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  const Center(
                                    child: Text(
                                      'ingredients',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    // width: MediaQuery.of(context).size.width,
                                    child: Text("\u25CF ${ingredientsList.join('\n\u25CF ')}",
                                      style: const TextStyle(fontSize: 19),
                                    ),
                                  ),
                                  

                                  const Divider(
                                    thickness: 2,
                                    height: 20,
                                  ),
                                  
                                  const Center(
                                    child: Text(
                                      'Directions',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.passValue.directions,
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                        const SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
