import 'dart:io';
import 'package:best_flutter_ui_templates/screen/OtpPage.dart';
import 'package:best_flutter_ui_templates/screen/details.dart';
import 'package:best_flutter_ui_templates/screen/home_screen.dart';
import 'package:best_flutter_ui_templates/screen/login.dart';
import 'package:best_flutter_ui_templates/screen/profile.dart';
import 'package:best_flutter_ui_templates/widget/dummy.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
     routes:  <String, WidgetBuilder>{
     LoginPage.routeName:(ctx)=>LoginPage(),
       ProfilePage.routeName:(ctx)=>ProfilePage(),
       OtpPage.routeName: (ctx) => new OtpPage(),
      Details.routeName:(ctx)=>Details(),
       HomeScreen.routeName:(ctx)=>HomeScreen(),
      
     }
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
        body: 
        // SplashScreen1()
        new SplashScreen(
      seconds: 05,
      navigateAfterSeconds:Dummy(),   //LoginPage(),
            // new HomeScreen(),
            title: new Text(
              'Welcome In Lonar',
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            image:
             new Image.asset('assets/images/logo.png'),
            backgroundColor: Colors.white,
            styleTextUnderTheLoader: new TextStyle(),
            photoSize: 100.0,
            onClick: () => print("Flutter Egypt"),
            loaderColor: Colors.red),
            );
        }
      
        getData() async {
            sleep(const Duration(seconds:5));
            final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('username');
       if (userId != null) {
    Navigator.pushNamed(context, HomeScreen.routeName);
    
     
    }else{
    Navigator.pushNamed(context, LoginPage.routeName);
    }
        }
}


