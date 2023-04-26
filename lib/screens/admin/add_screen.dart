import 'dart:io';

import 'package:cookbook/db/functions/db_recipe_functions.dart';
import 'package:cookbook/db/model/recipies.dart';
import 'package:cookbook/screens/admin/admin_home.dart';
import 'package:cookbook/widgets/add_ingredients.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final List<GlobalKey> _textKeys = [];
  final List<Widget> _textfields = [];
  final List<TextEditingController> _controllers = [];
  final List<String> _ingredientsList = [];
  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _directionController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _youtubeLink = TextEditingController();
  late String category;

  String? imagePath;

  String dropDownValue = 'Category';

  var items = ['Category', 'Breakfast', 'Lunch', 'Dinner'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < _controllers.length; i++) {
      _controllers.add(TextEditingController());
    }
  }

  Future<void> imagePick() async {
    final imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      setState(() {
        imagePath = imagePicked.path;
      });
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(238, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text('Add Recipe'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 200,
                      height: 120,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              opacity: imagePath == null ? 0 : 1,
                              image: imagePath == null
                                  ? const AssetImage(
                                          'assets/images/cookbooklogo.png')
                                      as ImageProvider
                                  : FileImage(File(imagePath!)))),
                      child: Visibility(
                        visible: imagePath == null,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () => imagePick(),
                                icon: const Icon(
                                  Icons.add_box_outlined,
                                  size: 30,
                                )),
                            const Text(
                              'Tap to add Recipe Image',
                              style: TextStyle(fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              szdBox(),
              recipeText(_recipeNameController, 'Recipe name', 1),
              szdBox(),
              recipeText(_durationController, 'Cooking time', 1),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 55,
                width: double.maxFinite,
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  value: 'Category',
                  items: items
                      .map(
                        (String items) => DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        ),
                      )
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
                              _ingredientsController, 'Add ingredients')),
                      IconButton(
                          iconSize: 35,
                          onPressed: () => addTextField(_textfields.length),
                          icon: const Icon(Icons.add_box_outlined))
                    ],
                  ),
                  ..._textfields
                ],
              ),
              szdBox(),
              recipeText(_directionController, 'Directions for Cook', 10),
              const SizedBox(
                height: 20,
              ),
              recipeText(_youtubeLink, 'Link to the video', 1),
              szdBox(),
              ElevatedButton.icon(
                  onPressed: () {
                    if (imagePath != null &&
                        _recipeNameController.text.isNotEmpty &&
                        _durationController.text.isNotEmpty &&
                        _ingredientsController.text.isNotEmpty &&
                        _directionController.text.isNotEmpty &&
                        _youtubeLink.text.isNotEmpty) {
                      onUploadButtonClicked();
                      addedSuccesully();
                    } else {
                      validCheck();
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add'))
            ],
          ),
        ),
      ])),
    );
  }

  void addTextField(key) {
    setState(() {
      // print('1');
      GlobalKey key = GlobalKey();
      _controllers.add(TextEditingController());
      _textKeys.add(key);
      _textfields.add(addIngredients(key));
      _ingredientsList.add('');
    });
  }

  void removeTextField(GlobalKey key) {
    setState(() {
      int index = _textKeys.indexOf(key);
      // _controllers[index].dispose();
      _controllers.removeAt(index);
      _textfields.removeAt(index);
      _textKeys.removeAt(index);
      _ingredientsList.removeAt(index);
    });
  }

  Widget addIngredients([GlobalKey? key]) {
    ObjectKey keys = const ObjectKey({});
    int index = _ingredientsList.length;
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: SizedBox(
        height: 52,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controllers[index],
                onChanged: (value) {
                  setState(() {
                    _ingredientsList[index] = value;
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
            IconButton(
              onPressed: () {
                addTextField(keys);
              },
              icon: const Icon(Icons.add_box_outlined),
              iconSize: 35,
            )
          ],
        ),
      ),
    );
  }

  Future<void> onUploadButtonClicked() async {
    print('Clicked');
    
    final recipeName = _recipeNameController.text.trim();
    final duration = _durationController.text.trim();
    final category = dropDownValue;
    final ingredients = _ingredientsController.text.trim();
    final extraIngredients = _ingredientsList;
    final direction = _directionController.text.trim();
    final link = _youtubeLink.text.trim();
    

    if (recipeName.isEmpty ||
        duration.isEmpty ||
        ingredients.isEmpty ||
        direction.isEmpty ||
        link.isEmpty) {
      print('returned');
      return;
    }
    print('reached');
    print(category);
    final recipeDetails = Recipes(
        imagePath: imagePath!,
        recipeName: recipeName,
        cookingTime: duration,
        catogory: category,
        ingredients: ingredients,
        extraIngredients: extraIngredients,
        directions: direction,
        url: link);

    uploadRecipe(recipeDetails);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const AdminHome(),
    ));
  }

  validCheck() {
    var errorMessage = '';
    if (imagePath == null &&
        _recipeNameController.text.isEmpty &&
        _durationController.text.isEmpty &&
        _ingredientsController.text.isEmpty &&
        _directionController.text.isEmpty &&
        _youtubeLink.text.isEmpty) {
      errorMessage = 'Please fill all the fields';
    } else if (imagePath == null) {
      errorMessage = 'Please add image';
    } else if (_recipeNameController.text.isEmpty) {
      errorMessage = 'Please add Recipe name';
    } else if (_durationController.text.isEmpty) {
      errorMessage = 'Please add cooking time';
    } else if (_ingredientsController.text.isEmpty) {
      errorMessage = 'Please add ingredients';
    } else if (_directionController.text.isEmpty) {
      errorMessage = 'Please add directions';
    } else if (_youtubeLink.text.isEmpty) {
      errorMessage = 'Please add any link of making video';
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          margin: const EdgeInsets.all(10),
          content: Text(errorMessage,style: const TextStyle(fontSize: 17),)));
  }

   void addedSuccesully(){
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(10),
      backgroundColor: Colors.green,
      content: Text('Recipe added succesfully',style: TextStyle(fontSize: 17),)));
  }
}
