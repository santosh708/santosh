// import 'package:best_flutter_ui_templates/screen/home_screen.dart';
// import 'package:best_flutter_ui_templates/service/home_service.dart';
// import 'package:best_flutter_ui_templates/theam/home_app_theme.dart';
// import 'package:best_flutter_ui_templates/widget/appBar1.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// class Like extends StatefulWidget {
//  int id;
//   Like(int id){
//     this.id=id;
//     print(id);
//   }
//   static const routeName = '/like';

//   @override
//   _LikeState createState() => _LikeState();
// }

// class _LikeState extends State<Like> {
//    List<dynamic>  _likeList = [];
//       void initState() {
//         print(widget.id);
//         setState(() {
//           APIHOME.likeList(widget.id).then((response){
//             print("ssdsd");
//           _likeList= List.from(response).toList();
//           });
//         });
//         super.initState();
//       }
//   final ScrollController _scrollController = ScrollController();

//   @override
//   Widget build(BuildContext context) {
  
//       Future<bool> _onBackPressed() async {
// Navigator.pushNamed(context, HomeScreen.routeName);
// return true;
// }
// String _title="likes";
//     return  WillPopScope(
//        onWillPop:_onBackPressed,
//           child: Theme(
//         data: HomeAppTheme.buildLightTheme(),
//         child: Container(
//           child: Scaffold(
//             body: Stack(
//               children: <Widget>[
//                 InkWell(
//                   splashColor: Colors.transparent,
//                   focusColor: Colors.transparent,
//                   highlightColor: Colors.transparent,
//                   hoverColor: Colors.transparent,
//                   onTap: () {
//                     FocusScope.of(context).requestFocus(FocusNode());
//                   },
//                   child: Column(
//                     children: <Widget>[
//                       GetAppBarUI1(_title,true),


//                         Expanded(
//                         child: NestedScrollView(
//                           controller: _scrollController,
//                           headerSliverBuilder:
//                               (BuildContext context, bool innerBoxIsScrolled) {
//                             return <Widget>[];
//                           },
//                           body: Container(
//                             padding: EdgeInsets.all(15.0),
//                             child: ListView.builder(
//                               itemCount: _likeList.length,
//                               scrollDirection: Axis.vertical,
//                               itemBuilder: (BuildContext context, int index) {
//                                 // var id = index + 1;
//                                 return Column(
//                                   children: <Widget>[
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: <Widget>[
//                                         ClipOval(
//                                             child: _likeList[index].pimg == null
//                                                 ? Image.asset(
//                                                     "assets/images/img.jpg",
//                                                     height: 50,
//                                                     width: 50,
//                                                     fit: BoxFit.cover,
//                                                   )
//                                                 : Image(
//                                                     image:
//                                                         CachedNetworkImageProvider(
//                                                             _likeList[index]
//                                                                 .pimg),
//                                                     height: 50,
//                                                     width: 50,
//                                                     fit: BoxFit.cover,
//                                                   )),
//                                         SizedBox(
//                                           width: 15,
//                                           height: 10,
//                                         ),
//                                         Flexible(
//                                           child: Container(
//                                               child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: <Widget>[
//                                               new Text(
//                                                 // "santosh zanak",
//                                                 _likeList[index].un,
//                                                 overflow: TextOverflow.fade,
//                                                 textAlign: TextAlign.left,
//                                                 style: TextStyle(
//                                                   fontWeight: FontWeight.w500,
//                                                   fontSize: 18,
//                                                 ),
//                                               ),
//                                               new Text(
//                                                 _likeList[index].cmt,
//                                                 overflow: TextOverflow.fade,
//                                                 textAlign: TextAlign.left,
//                                                 style: TextStyle(
//                                                   fontWeight: FontWeight.w400,
//                                                   fontSize: 16,
//                                                 ),
//                                               ),
//                                             ],
//                                           )),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 20,
//                                     )
//                                   ],
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                       )
//                       // Expanded(
//                       //   child: NestedScrollView(
//                       //     controller: _scrollController,
//                       //     headerSliverBuilder:
//                       //         (BuildContext context, bool innerBoxIsScrolled) {
//                       //       return <Widget>[];
//                       //     },
//                       //     body: Container(
//                       //       padding: EdgeInsets.all(15.0),
//                       //       child: ListView.builder(
//                       //         itemCount: _likeList.length,
//                       //         scrollDirection: Axis.vertical,
//                       //         itemBuilder: (BuildContext context, int index) {
//                       //           int id=index+1;
//                       //           return Column(
//                       //             children: <Widget>[
//                       //               Row(
//                       //                 mainAxisAlignment: MainAxisAlignment.start,
//                       //                 crossAxisAlignment:
//                       //                     CrossAxisAlignment.start,
//                       //                 children: <Widget>[
//                       //                   ClipOval(
//                       //                       child: Image(
//                       //                     image: CachedNetworkImageProvider(
//                       //                         _likeList[index].pimg),
//                       //                     height: 50,
//                       //                     width: 50,
//                       //                     fit: BoxFit.cover,
//                       //                   )),
//                       //                   SizedBox(
//                       //                     width: 15,
//                       //                     height: 10,
//                       //                   ),
//                       //                   Container(
//                       //                     padding: EdgeInsets.only(top: 10),
//                       //                     child: new Text(_likeList[index].un,
//                       //                       overflow: TextOverflow.fade,
//                       //                       textAlign: TextAlign.right,
//                       //                       style: TextStyle(
//                       //                         fontWeight: FontWeight.w400,
//                       //                         fontSize: 18,
//                       //                       ),
//                       //                     ),
//                       //                   ),
//                       //                 ],
//                       //               ),
//                       //               SizedBox(height: 20,)
//                       //             ],
//                       //           );
//                       //         },
//                       //       ),
//                       //     ),
//                       //   ),
//                       // )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:best_flutter_ui_templates/screen/home_screen.dart';
import 'package:best_flutter_ui_templates/service/home_service.dart';
import 'package:best_flutter_ui_templates/theam/home_app_theme.dart';
import 'package:best_flutter_ui_templates/widget/appBar1.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Like extends StatefulWidget {
  static const routeName = '/like';
  int id;
  Like(int id) {
    this.id = id;
  }
  @override
  _LikeState createState() => _LikeState();
}

class _LikeState extends State<Like> {
  void initState() {
    APIHOME.likeList(widget.id).then((value) => {
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
    Future<bool> _onBackPressed() async {
      Navigator.pushNamed(context, HomeScreen.routeName);
      return true;
    }

    String _title = "Like";
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
                                          // height: 10,
                                        ),
                                        Flexible(
                                          child: Container(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(
                                          width: 15,
                                          height: 15,
                                        ),
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
                                              // new Text(
                                              //   _likeList[index].cmt,
                                              //   overflow: TextOverflow.fade,
                                              //   textAlign: TextAlign.left,
                                              //   style: TextStyle(
                                              //     fontWeight: FontWeight.w400,
                                              //     fontSize: 16,
                                              //   ),
                                              // ),
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
                      // ListTile(
                      //   title: TextFormField(
                      //     keyboardType: TextInputType.multiline,
                      //     controller: _commentController,
                      //     decoration:
                      //         InputDecoration(labelText: 'Write a comment...'),
                      //     onFieldSubmitted: addLike,
                      //   ),
                      //   trailing: OutlineButton(
                      //     onPressed: () {
                      //       // addLike(_commentController.text);
                      //     },
                      //     borderSide: BorderSide.none,
                      //     child: Text("Post"),
                      //   ),
                      // ),
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
