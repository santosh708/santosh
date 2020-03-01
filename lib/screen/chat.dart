import 'dart:convert';
import 'package:best_flutter_ui_templates/screen/home_screen.dart';
import 'package:best_flutter_ui_templates/service/home_service.dart';
import 'package:best_flutter_ui_templates/theam/home_app_theme.dart';
import 'package:best_flutter_ui_templates/widget/appBar1.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Comment extends StatefulWidget {
  static const routeName = '/comment';
  int id;
  Comment(int id) {
    this.id = id;
  }
  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  void initState() {
    APIHOME.fetchComent(widget.id, 1, 10).then((value) => {
          setState(() {
            _likeList = List.from(value).toList();
            print(_mi);
          })
        });
    super.initState();
  }

  AnimationController animationController; 
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _commentController = TextEditingController();
  List<dynamic> _likeList = [];
  int _mi;
  @override
  Widget build(BuildContext context) {
    print(_likeList);
    
    addComment(String comment) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var a = {"mi": widget.id, "ui": prefs.getInt('userid'), "cmt": comment};
      var b = jsonEncode(a);
      APIHOME.postComment(b).then((response) {
        APIHOME.fetchComent(widget.id, 1, 20).then((value) {
          setState(() {
            _likeList = value;
          });
          _commentController.text = "";
        });
      });
    }

    Future<bool> _onBackPressed() async {
      Navigator.pushNamed(context, HomeScreen.routeName);
      return true;
    }

    String _title = "Comment";
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Theme(
        data: HomeAppTheme.buildLightTheme(),
        child: Container(
          child: Scaffold(
            body: Stack(
              children: <Widget>[
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Column(
                    children: <Widget>[
                      GetAppBarUI1(_title, true),
                      Expanded(
                        child: NestedScrollView(
                          controller: _scrollController,
                          headerSliverBuilder:
                              (BuildContext context, bool innerBoxIsScrolled) {
                            return <Widget>[];
                          },
                          body: Container(
                            padding: EdgeInsets.all(15.0),
                            child: ListView.builder(
                              itemCount: _likeList.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                // var id = index + 1;
                                return Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        ClipOval(
                                            child: _likeList[index].pimg == null
                                                ? Image.asset(
                                                    "assets/images/img.jpg",
                                                    height: 50,
                                                    width: 50,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image(
                                                    image:
                                                        CachedNetworkImageProvider(
                                                            _likeList[index]
                                                                .pimg),
                                                    height: 50,
                                                    width: 50,
                                                    fit: BoxFit.cover,
                                                  )),
                                        SizedBox(
                                          width: 15,
                                          height: 10,
                                        ),
                                        Flexible(
                                          child: Container(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              new Text(
                                                // "santosh zanak",
                                                _likeList[index].un,
                                                overflow: TextOverflow.fade,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              new Text(
                                                _likeList[index].cmt,
                                                overflow: TextOverflow.fade,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Divider(),
                      ListTile(
                        title: TextFormField(
                          keyboardType: TextInputType.multiline,
                          controller: _commentController,
                           validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter Mobail No';
                                  } 
                                  else if (value.length==0) {
                                    return 'Please enter valid Mobail No';
                                  } 
                                  // else if (!regExp.hasMatch(value)) {
                                  //   return 'Please enter valid mobile number';
                                  // }
                                  return null;
                                },
                          decoration:
                              InputDecoration(labelText: 'Write a comment...'),
                          onFieldSubmitted: addComment,
                        ),
                        trailing: OutlineButton(
                          onPressed: () {
                            addComment(_commentController.text);
                          },
                          borderSide: BorderSide.none,
                          child: Text("Post"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
