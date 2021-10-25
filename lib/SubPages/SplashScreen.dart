import 'dart:async';

import 'package:flutter/material.dart';
import 'package:spicy_food_vendor/SubPages/InitialPage.dart';
import 'package:spicy_food_vendor/Utils/Constants.dart';

class SplashScreen extends StatefulWidget {
  // const SplashScreen({key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    this._loadWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff09B44C),
      body: Center(
        child: Image(
          image: AssetImage("assets/images/splash.jpg"),
          height: 250,
        ),
      ),
    );
  }

  _loadWidget() async {
    return Timer(Duration(seconds: 4), navigationLogin);
  }

  void navigationLogin() {
    print("login");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => InitialPage()));
  }
}
