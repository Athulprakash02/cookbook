import 'dart:io';

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
  List<GlobalKey> _textKeys = [];
  List<Widget> _textfields = [];
  List<TextEditingController> _controllers = [];
  List<String> _ingredientsList = [];
  TextEditingController _recipeNameController = TextEditingController();
  TextEditingController _durationController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _directionController = TextEditingController();
  TextEditingController _ingredientsController = TextEditingController();
  TextEditingController _youtubeLink = TextEditingController();
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
    print('object');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(238, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(217, 216, 214, 214),
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
                              image: imagePath == null
                                  ? const AssetImage('') as ImageProvider
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

              ElevatedButton.icon(
                  onPressed: () {
                    prints();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const AdminHome(),
                    ));
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

  void prints() {
    print(_recipeNameController.text);
    print(_durationController.text);

    print(category);
    print(_ingredientsController.text);
    _ingredientsList.forEach((element) {
      print(element);
    });
    print(_directionController.text);
    print(_youtubeLink.text);
  }
}
