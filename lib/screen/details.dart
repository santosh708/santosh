
import 'package:best_flutter_ui_templates/screen/chat.dart';
import 'package:best_flutter_ui_templates/screen/home_screen.dart';
import 'package:best_flutter_ui_templates/theam/home_app_theme.dart';
import 'package:best_flutter_ui_templates/widget/appBar1.dart';
import 'package:best_flutter_ui_templates/widget/like_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Details extends StatelessWidget {
  String _title = "Details";
  static const routeName = '/details';

  chatNevigation(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(Comment.routeName);
  }

  kFormatter(number) {
    if (number > 9999999) {
      return '${(number / 10000000).toStringAsFixed(2)}t';
    }
    if (number > 999999) {
      return '${(number / 1000000).toStringAsFixed(2)}m';
    }
    if (number > 999) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    }
    return '$number';
  }

  void likeFunction(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(Like.routeName);
  }

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
  Future<bool> _onBackPressed() async {
Navigator.pushNamed(context, HomeScreen.routeName);
return true;
}

    return WillPopScope(
       onWillPop:_onBackPressed,
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
                      GetAppBarUI1(_title,true),
                      Expanded(
                        child: NestedScrollView(
                          controller: _scrollController,
                          headerSliverBuilder:
                              (BuildContext context, bool innerBoxIsScrolled) {
                            return <Widget>[];
                          },
                          body: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 16, bottom: 16),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(16.0)),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.6),
                                          offset: const Offset(4, 4),
                                          blurRadius: 16,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(16.0)),
                                          child: Stack(
                                            children: <Widget>[
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: <Widget>[
                                                  InkWell(
                                                      child:
                                                      Image(

                                                        image: CachedNetworkImageProvider(
                                                            arguments['img']),
                                                        fit: BoxFit.fill,
                                                      ),
                                                      ),
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    color: HomeAppTheme
                                                            .buildLightTheme()
                                                        .backgroundColor,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Container(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: <Widget>[
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: <
                                                                      Widget>[
                                                                    Image(
                                                                      image: CachedNetworkImageProvider(
                                                                          arguments[
                                                                              'img']),
                                                                      height: 30,
                                                                      width: 30,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    new Text(
                                                                      '${arguments["t"]}',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .fade,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Icon(
                                                                  FontAwesomeIcons
                                                                      .thumbsUp,
                                                                  size: 20,
                                                                  color: HomeAppTheme
                                                                          .buildLightTheme()
                                                                      .primaryColor,
                                                                ),
                                                                SizedBox(
                                                                  width: 8,
                                                                ),
                                                                InkWell(
                                                                  onTap: () =>
                                                                      likeFunction(
                                                                          context),
                                                                  child: new Text(
                                                                    kFormatter(
                                                                        arguments[
                                                                            'lc']),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .fade,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w200,
                                                                      fontSize:
                                                                          20,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 8,
                                                                ),
                                                                Icon(
                                                                  FontAwesomeIcons
                                                                      .solidComments,
                                                                  size: 20,
                                                                  color: HomeAppTheme
                                                                          .buildLightTheme()
                                                                      .primaryColor,
                                                                ),
                                                                SizedBox(
                                                                  width: 8,
                                                                ),
                                                                InkWell(
                                                                  onTap: () =>
                                                                      chatNevigation(
                                                                          context),
                                                                  child: new Text(
                                                                    kFormatter(
                                                                        arguments[
                                                                            'lc']),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .fade,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w200,
                                                                      fontSize:
                                                                          20,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(13),
                                                    color: HomeAppTheme
                                                            .buildLightTheme()
                                                        .backgroundColor,
                                                    child: SingleChildScrollView(
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Text(
                                                              arguments[
                                                                  'caption'],
                                                              overflow:
                                                                  TextOverflow
                                                                      .fade,
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.8)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              // Positioned(
                                              //   top: 8,
                                              //   right: 8,
                                              //   child: Material(
                                              //     color: Colors.transparent,
                                              //     child: InkWell(
                                              //       borderRadius: const BorderRadius.all(
                                              //         Radius.circular(32.0),
                                              //       ),
                                              //       onTap: () => getColorChnange(context),
                                              //       child: Padding(
                                              //         padding: const EdgeInsets.all(8.0),
                                              //         child: _selectedIndex == 0
                                              //             ? Icon(Icons.favorite,
                                              //                 color: Colors.red)
                                              //             : Icon(Icons.favorite_border,
                                              //                 color: Colors.green),
                                              //       ),
                                              //     ),
                                              //   ),
                                              // )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ),
                        ),
                      )
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
