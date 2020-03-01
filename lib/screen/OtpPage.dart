import 'package:best_flutter_ui_templates/screen/home_screen.dart';
import 'package:best_flutter_ui_templates/screen/login.dart';
import 'package:best_flutter_ui_templates/screen/profile.dart';
import 'package:best_flutter_ui_templates/service/login_service.dart';
import 'package:flutter/material.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
class OtpPage extends StatefulWidget {
  static const routeName = '/OtpPage';
  static String tag = 'login-page';
  @override
  _OtpPageState createState() => new _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  RegExp regExp = new RegExp(
      r'/^\s*(?:\+?(\d{1,3}))?[- (]*(\d{3})[- )]*(\d{3})[- ]*(\d{4})(?: *[x/#]{1}(\d+))?\s*$/');
  @override
  Widget build(BuildContext context) {
    String arguments = ModalRoute.of(context).settings.arguments;
    final logo = Hero(
      tag: 'Lonar',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 100.0,
        child: Image.asset('assets/images/logo.png'),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 40), child: logo),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, top: 20.0, right: 16.0, bottom: 30),
                        child: Text(
                          "Enter your otp",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                          padding:
                              const EdgeInsets.only(top: 40.0, bottom: 40.0),
                          child: Container(
                            child: PinEntryTextField(
                              onSubmit: (String pin) async {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Pin"),
                                        content: Text('Pin entered is $pin'),
                                      );
                                    }); //end showDialog()

                                var a = {"mob": arguments, "otp": pin};
                                LoginApi.getValidate(a).then((value) => {
                                      print(value.userid),
                                      if(value.firstname == null)
                                        {
                                          Navigator.popAndPushNamed(
                                              context, ProfilePage.routeName)
                                        }
                                      else if (value.userid == null)
                                        {
                                          Navigator.popAndPushNamed(
                                              context, LoginPage.routeName)
                                        }
                                      else
                                        {
                                          Navigator.popAndPushNamed(
                                              context, HomeScreen.routeName)
                                        }
                                    });
                              }, // end onSubmit
                            ),
                          ))
                    ])
              ],
            )
          ],
        ),
      ),
    );
  }
}
