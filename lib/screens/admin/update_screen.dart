import 'dart:io';

import 'package:cookbook/db/model/recipies.dart';
import 'package:cookbook/widgets/add_ingredients.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class UpdateScreen extends StatefulWidget {
  final int index;
  

  UpdateScreen({Key? key,
  
  required this.index
  }) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final List<GlobalKey> _textKeys = [];
  final List<Widget> _textfields = [];
  final List<TextEditingController> _controllers = [];
  final List<String> _ingredientsList = [];
  late TextEditingController _recipeNameController;
  late TextEditingController _durationController;
  late TextEditingController _categoryController;
  late TextEditingController _directionController;
  late TextEditingController _ingredientsController;
  late TextEditingController _extraIngredientsController;

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

  var itemsCategory = [
    'Category',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Indian',
    'Italian',
    'Arabian',
    'Chinese'
  ];
  String dropDownValue = 'Category';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // GlobalKey mainKey = GlobalKey();

    recipeBox = Hive.box('recipe_list');
    recipe = recipeBox.getAt(widget.index) as Recipes;

    _recipeNameController =
        TextEditingController(text: recipe.recipeName.toString());
    _durationController =
        TextEditingController(text: recipe.cookingTime.toString());
    _categoryController =
        TextEditingController(text: recipe.catogory.toString());
    _ingredientsController =
        TextEditingController(text: recipe.ingredients.toString());
    for (int i = 0; i < _ingredientsList.length; i++) {
      addTextField(i);
    }
    _directionController =
        TextEditingController(text: recipe.directions.toString());
    _youtubeLinkController = TextEditingController(text: recipe.url.toString());

    _ingredientsList.clear();
    _controllers.clear();
    _textfields.clear();
    print(_categoryController.text);

    // _textfields.add(addTextField(0));

    // for(var i=0;i<recipe.ingredients.length;i++){
    //   // GlobalKey mainKey = GlobalKey();
    // _ingredientsList.add(recipe.ingredients[i]);
    // _controllers.add(TextEditingController(text: recipe.ingredients[i]));
    // _textKeys.add(GlobalKey());
    // _textfields.add(addIngredients(_textKeys[i]));

    //   _textfields.add(addTextField(i));
    // }
  }

  // Future<Recipes> fetchRecipe(String id) async{
  //   final r
  // }
  Future<void> imagePick() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        imagePath = pickedImage.path;
      });
    }
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
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imagePath == null
                                  ? FileImage(File(recipe.imagePath))
                                  : FileImage(
                                      File(imagePath ?? recipe.imagePath)))),
                    ),
                    onTap: () {
                      imagePick();
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
                    value: dropDownValue,
                    items: itemsCategory
                        .map(
                          (String itemsCategory) => DropdownMenuItem(
                            value: itemsCategory,
                            child: Text(itemsCategory),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        dropDownValue = value!;
                        category = value;
                        _categoryController.text = value;
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
                                _ingredientsController, 'hintText', 1)),
                        IconButton(
                            iconSize: 35,
                            onPressed: () {
                              addTextField(_textfields.length);
                            },
                            icon: Icon(Icons.add_box_outlined)),
                      ],
                    ),
                    ..._textfields,
                  ],
                ),
                szdBox(),
                recipeText(_directionController, 'Directions for cook', 15),
                szdBox(),
                recipeText(_youtubeLinkController, 'Link to the video', 1),
                szdBox(),
                ElevatedButton.icon(
                    onPressed: () {
                      if (imagePath != null &&
                          _recipeNameController.text.isNotEmpty &&
                          _durationController.text.isNotEmpty &&
                          _ingredientsController.text.isNotEmpty &&
                          _directionController.text.isNotEmpty &&
                          _youtubeLinkController.text.isNotEmpty) {
                      } else {
                        validCheck();
                      }
                    },
                    icon: Icon(Icons.update),
                    label: Text('Update'))
              ],
            ),
          )
        ],
      )),
    );
  }

  addTextField(int index2) {
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
    int index1 = _ingredientsList.length;

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
                controller: _controllers[index1],
                onChanged: (value) {
                  setState(() {
                    _ingredientsList[index1] = value;
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

  validCheck() {
    var errorMessage = '';
    if (imagePath == null &&
        _recipeNameController.text.isEmpty &&
        _durationController.text.isEmpty &&
        _ingredientsController.text.isEmpty &&
        _directionController.text.isEmpty &&
        _youtubeLinkController.text.isEmpty) {
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
    } else if (_youtubeLinkController.text.isEmpty) {
      errorMessage = 'Please add any link of making video';
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.all(10),
        content: Text(
          errorMessage,
          style: const TextStyle(fontSize: 17),
        )));
  }

  void addedSuccesully() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.green,
        content: Text(
          'Recipe added succesfully',
          style: TextStyle(fontSize: 17),
        )));
  }

  Future<void> onUpdateButtonClicked(int index) async {
    final recipeName = _recipeNameController.text;
    final duration = _durationController.text;
    final _category = _categoryController.text;
    final ingrdients = _ingredientsController.text;
    // final extraIngredients =
  }
}
