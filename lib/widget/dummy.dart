import 'package:best_flutter_ui_templates/screen/home_screen.dart';
import 'package:best_flutter_ui_templates/screen/login.dart';
import 'package:best_flutter_ui_templates/screen/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dummy extends StatefulWidget {
  @override
  _DummyState createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  
  getData() async {
           SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('userid') == null) {
      Navigator.pushNamed(context, LoginPage.routeName);
    } else if (prefs.getString('firstname') == null) {
      Navigator.pushNamed(context, ProfilePage.routeName);
    } else {
      Navigator.pushNamed(context, HomeScreen.routeName);
    }
  }
  get()  {
    getData();
  }
  Future<void> initState()  {
 get();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
