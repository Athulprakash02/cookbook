import 'package:cookbook/db/model/login_model.dart';
import 'package:cookbook/main.dart';
import 'package:cookbook/screens/user/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future signUp(LoginData value) async {
  final signed = await Hive.openBox<LoginData>('login_db');
  final _details = await signed.add(value);
  value.id = _details;
}

onClickSignUp(_email, _name, _password, _confirmPassword, context) {
  

  final userLogin = LoginData(
      fullName: _name,
      email: _email,
      password: _password,
      confirmPassword: _confirmPassword);

  signUp(userLogin);

  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (route) => false);
} 

Future exists(String mailId, ctx, _name, _password, _confirmPassword) async {
  final emailBox = await Hive.openBox<LoginData>('login_db');
  final emails = emailBox.values.toList();

  final emailExists =
      emails.where((element) => element.email == mailId).isNotEmpty;

  if (emailExists) {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: const Text(
          'Email already exists',
          style: TextStyle(fontSize: 18),
        )));
  } else {
    onClickSignUp(mailId, _name, _password, _confirmPassword, ctx);
  }
}


 Future<String> getUser(String email) async{
  print('entered');
    final userBox =await Hive.openBox<LoginData>('login_db');
    
    
    var users = userBox.values.firstWhere(((user) => user.email == email));
    print(users);
   
      return users.fullName;
      // emailLoggedIn = users.fullName;
      // print('name ${users.fullName}');
      // return user;
   
  }





