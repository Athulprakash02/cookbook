import 'package:cookbook/main.dart';
import 'package:cookbook/screens/admin/admin_home.dart';
import 'package:cookbook/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 70, 30, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/cookbooklogo.png',
                  width: 150,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          blurStyle: BlurStyle.outer,
                          blurRadius: 5,
                          spreadRadius: 7,
                          color: Colors.grey.withOpacity(1),
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                              child: Text(
                            'Admin Login',
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          )),
                          const SizedBox(
                            height: 50,
                          ),
                          const Text(
                            'Email',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: textFieldWidget('abc@gmail.com', false,
                                _email, TextInputType.emailAddress),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Password',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: textFieldWidget('Password', true, _password,
                                TextInputType.visiblePassword),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Forget Password?',
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 9, 79, 136)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    padding:
                                        const EdgeInsets.fromLTRB(25, 8, 25, 8),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                onPressed: () {
                                  checkLogin(context);
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )),
                          ),
                         
                        ]),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  checkLogin(BuildContext ctx) async{
    final email = _email.text.trim();
    final password = _password.text.trim();

    if((email == adminMail) && (password == adminPass)){
      final sharedPref = await SharedPreferences.getInstance();
      await sharedPref.setBool(SAVE_KEY_NAME, true);

      Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (context) => AdminHome(),));
    } else {
      final errorMessage = 'Email and Password does not match';

      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          backgroundColor: const Color.fromARGB(255, 196, 45, 21),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(10),
          content: Text(errorMessage)));
    }
  }
}
