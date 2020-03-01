import 'dart:async';
import 'package:best_flutter_ui_templates/screen/home_screen.dart';
import 'package:flutter/material.dart';
class SplashScreen1 extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen1> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 15),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/splash.png'),
      ),
    );
  }
}
