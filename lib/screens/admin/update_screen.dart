import 'package:cookbook/db/model/recipies.dart';
import 'package:cookbook/widgets/add_ingredients.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UpdateScreen extends StatefulWidget {
  final int index;

  const UpdateScreen({super.key, required this.index});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  late TextEditingController _recipeNameController;
  late TextEditingController _durationController;
  late TextEditingController _categoryController;
  late TextEditingController _directionController;
  late TextEditingController _ingredientsController;
  late TextEditingController _youtubeLinkController;

  int id = 0;
  String? recipeName;
  String? duration;
  String? category;
  List<String>? ingredients;
  String? direction;
  String? youtubeLink;
  String? imagePath;

  late Box<Recipes> recipeBox;
  late Recipes recipe;
  String dropDownValue = 'Category';
  var items = [
    'Category',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Indian',
    'Italian',
    'Arabian',
    'Chinese'
  ];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    recipeBox = Hive.box('recipe_list');

    _recipeNameController = TextEditingController();
    _durationController = TextEditingController();
    _categoryController = TextEditingController();
    _ingredientsController = TextEditingController();
    _directionController = TextEditingController();
    _youtubeLinkController = TextEditingController();

    recipe = recipeBox.getAt(widget.index) as Recipes;
    print(widget.index);

    _recipeNameController.text = recipe.recipeName.toString();
    _durationController.text = recipe.cookingTime.toString();
    _categoryController.text = recipe.catogory.toString();

    _directionController.text = recipe.directions.toString();
    _youtubeLinkController.text = recipe.url.toString();
    print(_categoryController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(238, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text('Update Recipe'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: InkWell(
                    child: Container(
                      width: 200,
                      height: 120,
                      decoration: BoxDecoration(color: Colors.amber),
                    ),
                    onTap: () {
                      print('object');
                    },
                  ),
                ),
                szdBox(),
                recipeText(_recipeNameController, 'Recipe name', 1),
                szdBox(),
                recipeText(_durationController, 'Cooking time', 1),
                szdBox(),
                SizedBox(
                  height: 55,
                  width: double.maxFinite,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    value: 'Category',
                    items: items
                        .map((String items) =>
                            DropdownMenuItem(value: items, child: Text(items)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        dropDownValue = value!;
                        category = value;
                      });
                    },
                  ),
                ),
                szdBox(),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: recipeText(
                                _recipeNameController, 'hintText', 1)),
                        IconButton(
                            iconSize: 35,
                            onPressed: () {
                              // addTextField(key);
                            },
                            icon: Icon(Icons.add_box_outlined)),
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      )),
    );
  }

  void addTextField(key) {
    setState(() {
      // print('1');
      GlobalKey key = GlobalKey();
      // _controllers.add(TextEditingController());
      // _textKeys.add(key);
      // _textfields.add(addIngredients(key));
      // _ingredientsList.add('');
    });
  }

  void removeTextField(GlobalKey key) {
    setState(() {
      // int index = _textKeys.indexOf(key);
      // // _controllers[index].dispose();
      // _controllers.removeAt(index);
      // _textfields.removeAt(index);
      // _textKeys.removeAt(index);
      // _ingredientsList.removeAt(index);
    });
  }

  Widget addIngredients([GlobalKey? key]) {
    ObjectKey keys = const ObjectKey({});
    // int index = _ingredientsList.length;

    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: SizedBox(
        height: 52,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                autofocus: true,
                maxLines: 1,
                // controller: _controllers[index],
                onChanged: (value) {
                  setState(() {
                    // _ingredientsList[index] = value;
                  });
                },
                key: keys,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          if (key != null) {
                            removeTextField(key);
                          }
                        },
                        icon: const Icon(Icons.clear)),
                    hintText: 'Add ingredients',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            // Visibility(
            //   visible: isVisible,
            //   child: IconButton(
            //     onPressed: () {
            //       addTextField(keys);
            //     },
            //     icon: const Icon(Icons.add_box_outlined),
            //     iconSize: 35,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
