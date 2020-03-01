import 'package:best_flutter_ui_templates/screen/OtpPage.dart';
import 'package:best_flutter_ui_templates/service/login_service.dart';
import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

static const routeName = '/LoginPage';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  RegExp regExp = new RegExp(r'/^\s*(?:\+?(\d{1,3}))?[- (]*(\d{3})[- )]*(\d{3})[- ]*(\d{4})(?: *[x/#]{1}(\d+))?\s*$/');
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                          "Enter your phone number",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Form(
                        key: _formKey,
                        autovalidate: true,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: new Container(),
                              flex: 1,
                            ),
                            Flexible(
                              child: new TextFormField(
                                controller: myController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter Mobail No';
                                  } 
                                  else if (value.length !=10) {
                                    return 'Please enter valid Mobail No';
                                  } 
                                  // else if (!regExp.hasMatch(value)) {
                                  //   return 'Please enter valid mobile number';
                                  // }
                                  return null;
                                },
                                textAlign: TextAlign.start,
                                autofocus: false,
                                enabled: true,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.black),
                              ),
                              flex: 9,
                            ),
                            Flexible(
                              child: new Container(),
                              flex: 1,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
                        child: new Container(
                          width: 150.0,
                          height: 40.0,
                          child: new RaisedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                var mobailNo= myController.text;
                                LoginApi.postOtp(mobailNo).then((value) => {
                                Navigator.of(context).pushNamed(OtpPage.routeName,arguments:myController.text )
                                });
                                }
                              },
                              child: Text("Get OTP"),
                              textColor: Colors.white,
                              color: Colors.red,
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(30.0))),
                        ),
                      )
                    ])
              ],
            )
          ],
        ),
      ),
    );
  }
}

// import 'package:best_flutter_ui_templates/screen/OtpPage.dart';
// import 'package:flutter/material.dart';
// class LoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     List<Widget> widgetList = [

//     ];

//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.red,
//           title: Text("Login", style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//           ),
//         ),
//         backgroundColor: Color(0xFFeaeaea),
//         body:ListView(
//          shrinkWrap: true,
//             scrollDirection: Axis.vertical,
//             children: <Widget>[Column(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[

//               Padding(
//                 padding: const EdgeInsets.only(
//                     left: 16.0, top: 20.0, right: 16.0),
//                 child: Text("Enter your phone number",
//                   style: TextStyle(
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black),
//                   textAlign: TextAlign.center,),
//               ),

//               Padding(
//                 padding: const EdgeInsets.only(top: 30.0),
//                 child: Image(
//                   image: AssetImage('Assets/images/otp-icon.png'),
//                   height: 120.0,
//                   width: 120.0,),
//               ),

//               Row(
//                 children: <Widget>[

//                   Flexible(
//                     child: new Container(
//                     ),
//                     flex: 1,
//                   ),

//                   Flexible(
//                     child: new TextFormField(
//                       textAlign: TextAlign.center,
//                       autofocus: false,
//                       enabled: false,
//                       initialValue: "+91",
//                       style: TextStyle(fontSize: 20.0, color: Colors.black),
//                     ),
//                     flex: 3,
//                   ),

//                   Flexible(
//                     child: new Container(
//                     ),
//                     flex: 1,
//                   ),

//                   Flexible(
//                     child: new TextFormField(
//                       textAlign: TextAlign.start,
//                       autofocus: false,
//                       enabled: true,
//                       keyboardType: TextInputType.number,
//                       textInputAction: TextInputAction.done,
//                       style: TextStyle(fontSize: 20.0, color: Colors.black),
//                     ),
//                     flex: 9,
//                   ),

//                   Flexible(
//                     child: new Container(
//                     ),
//                     flex: 1,
//                   ),

//                 ],
//               ),

//               Padding(
//                 padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
//                 child: new Container (
//                   width: 150.0,
//                   height: 40.0,
//                   child: new RaisedButton(onPressed: () {
//                     Navigator.of(context).pushNamed(OtpPage.routeName);
//                   },
//                       child: Text("Get OTP"),
//                       textColor: Colors.white,
//                       color: Colors.red,
//                       shape: new RoundedRectangleBorder(
//                           borderRadius: new BorderRadius.circular(30.0))
//                   ),
//                 ),
//               )
//             ]
//         )],)
//     );

//   }

// }
