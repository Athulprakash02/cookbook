import 'package:cookbook/screens/admin/admin_home.dart';
import 'package:cookbook/widgets/add_ingredients.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  List<GlobalKey> _textKeys = [];
  List<Widget> _textfields = [];
  List<TextEditingController> _controllers = [];

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
                child: ClipRRect(
                  child: Container(
                    width: 200,
                    height: 160,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.add,
                          size: 30,
                        ),
                        Text(
                          'Tap to add Recipe Image',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                  decoration: InputDecoration(
                      hintText: 'Recipe Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)))),
              const SizedBox(
                height: 20,
              ),
              TextField(
                  decoration: InputDecoration(
                      hintText: 'Cooking Time',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)))),
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
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Add ingredients',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      )),
                      IconButton(
                        iconSize: 35,
                          onPressed: () => addTextField(_textfields.length),
                          icon: const Icon(
                            
                            Icons.add_box_outlined))
                    ],
                  ),
                  ..._textfields
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                maxLines: 10,
                  decoration: InputDecoration(
                    
                      hintText: 'Directions',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)))),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                  onPressed: () {
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
      _textKeys.add(key);
      _textfields.add(addIngredients(key));
    });
  }

  void removeTextField(GlobalKey key) {
    setState(() {
      print("object $key");
      int index = _textKeys.indexOf(key);
      _textfields.removeAt(index);
      _textKeys.removeAt(index);
    });
  }

  Widget addIngredients([GlobalKey? key]) {
    ObjectKey keys = const ObjectKey({});
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: SizedBox(
        height: 52,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                // controller: _controllers[1],
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
}
