import 'package:cookbook/db/functions/db_functions.dart';
import 'package:cookbook/main.dart';
import 'package:cookbook/screens/managing/manage_screen.dart';
import 'package:cookbook/screens/user/home_screen.dart';
import 'package:cookbook/screens/user/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {

   @override
  void initState() {
    checkAdminLoggedIn();
    checkUserLoggedIn();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/cookbooklogo.png',width: 180,),
        
      ),
    );
  }

   @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  Future gotoLogin() async{
    await Future.delayed(const Duration(seconds: 2));

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen(),)); 
  }

  Future <void> checkUserLoggedIn() async{
    final userSharePref= await SharedPreferences.getInstance();
    final _userLoggedIn = userSharePref.getBool(userLoggedIn);
    final user = userSharePref.getString(emailLoggedIn);
    if(_userLoggedIn == null || _userLoggedIn == false){
      gotoLogin();
    }else{
      getUser();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => const HomeScreen(),));
    }
  }


  Future <void> checkAdminLoggedIn() async{
    final _SharedPref = await SharedPreferences.getInstance();
    final _adminLoggedIn = _SharedPref.getBool(SAVE_KEY_NAME);
    if (_adminLoggedIn == null || _adminLoggedIn == false){
      gotoLogin();

    }else{
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => const AdminHome(),));
    }
  }



}