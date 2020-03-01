import 'package:best_flutter_ui_templates/screen/home_screen.dart';
import 'package:best_flutter_ui_templates/screen/login.dart';

import 'package:best_flutter_ui_templates/theam/home_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetAppBarUI1 extends StatelessWidget {
  final String appBarTitile;
  final bool status;
  const GetAppBarUI1(this.appBarTitile, this.status);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: HomeAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: status
                    ? InkWell(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(32.0),
                        ),
                        onTap: () async {
                          final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                             if(prefs.getString('firstname')==null){

                             }else{
                               Navigator.pushNamed(context, HomeScreen.routeName);
                             }
                          
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.arrow_back),
                        ),
                      )
                    : Container(),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  appBarTitile,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () async {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setInt('userid', null);
                        prefs.setString('userName',null);
                        prefs.setString(
                            'firstname', null);
                        prefs.setString('lastname', null);
                        prefs.setString('empNo', null);
                        prefs.setString('mob', null);
                        Navigator.pushNamed(context, LoginPage.routeName);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(FontAwesomeIcons.signOutAlt),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
