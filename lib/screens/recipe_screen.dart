import 'package:cookbook/screens/user/review_screen.dart';
import 'package:flutter/material.dart';


class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  Widget build(BuildContext context) {
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
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage('assets/images/pizza-386717__340.jpg'),
                          fit: BoxFit.cover)),
                )),
            Positioned(
              top: 30,
              left: 20,
                child:
                    CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 234, 201, 198),
                      radius: 25,
                      child: IconButton(
                        iconSize: 35,
                        onPressed: () {
                          Navigator.of(context).pop();
                        }, icon: const Icon(Icons.arrow_back_sharp)),
                    )),
                     Positioned(
              top: 30,
              right: 20,
                child:
                    CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 234, 201, 198),
                      radius: 25,
                      child: IconButton(
                        iconSize: 30,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReviewScreen(),));
                        }, icon: const Icon(Icons.reviews_outlined)),
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
                        const Text(
                          'Chicken golden delight',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: const [
                            Icon(Icons.watch_later_outlined),
                            SizedBox(
                              width: 5,
                            ),
                            Text('45 Mins')
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
                                children: const [
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  Text(
                                    'ingredients',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '1(10 3/4 ounce) can cream of chicken soup, undiluted \n3⁄4cup sour cream \n1⁄4cup milk \n1cup cubed cooked chicken \n2 1⁄2cups shredded cheddar cheese, \n2cups frozen hash browns, thawed1(10 3/4 ounce) can cream of chicken soup, undiluted \n3⁄4cup sour cream \n1⁄4cup milk \n1cup cubed cooked chicken \n2 1⁄2cups shredded cheddar cheese, \n2cups frozen hash browns, thawed ',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  Divider(
                                    thickness: 2,
                                    height: 20,
                                  ),
                                  // SizedBox(height: 15,),
                                  Text(
                                    'Directions',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '1(10 3/4 ounce) can cream of chicken soup, undiluted \n3⁄4cup sour cream \n1⁄4cup milk \n1cup cubed cooked chicken \n2 1⁄2cups shredded cheddar cheese, \n2cups frozen hash browns, thawed 1(10 3/4 ounce) can cream of chicken soup, undiluted \n3⁄4cup sour cream \n1⁄4cup ',
                                    style: TextStyle(fontSize: 17),
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
