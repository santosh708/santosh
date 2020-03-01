import 'package:best_flutter_ui_templates/model/home_list_data.dart';
import 'package:best_flutter_ui_templates/screen/chat.dart';
import 'package:best_flutter_ui_templates/screen/profile1.dart';
import 'package:best_flutter_ui_templates/service/home_service.dart';
import 'package:best_flutter_ui_templates/theam/home_app_theme.dart';
import 'package:best_flutter_ui_templates/widget/like_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';
import 'details.dart';

class HotelListView extends StatefulWidget {
  const HotelListView(
      {Key key,
      this.hotelData,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);
  final VoidCallback callback;
  final HomeListData hotelData;
  final AnimationController animationController;
  final Animation<dynamic> animation;
  @override
  _HotelListViewState createState() => _HotelListViewState();
}

class _HotelListViewState extends State<HotelListView> {
  int _selectedIndex = 1;
  bool likeFlag = false;
  bool _descTextShowFlag = false;
  kFormatter(number) {
    if (number > 9999999) {
      return '${(number / 10000000).toStringAsFixed(2)}t';
    }
    if (number > 999999) {
      return '${(number / 1000000).toStringAsFixed(2)}m';
    }
    if (number > 999) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    } else {
      return '$number';
    }
  }

  Future likePic(context, flag) async {
    if (!flag) {
      setState(() {
        APIHOME.likeImg(widget.hotelData.id).then((response) {
          Toast.show(response.toString(), context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        });
        widget.hotelData.lc = widget.hotelData.lc + 1;
        widget.hotelData.ul = true;
        likeFlag = true;
      });
    } else {
      setState(() {
        APIHOME.likeImg(widget.hotelData.id).then((response) {
          Toast.show(response.toString(), context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        });
        widget.hotelData.lc = widget.hotelData.lc - 1;
        widget.hotelData.ul = false;
      });
    }
  }

  void likeFunction(BuildContext ctx, id) {
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => Like(id)));
  }

  void details(BuildContext ctx, HomeListData hotelData) {
    print(hotelData);
    var a = {
      "img": hotelData.img,
      "t": hotelData.t,
      "un": hotelData.un,
      "id": hotelData.id,
      "cc": hotelData.cc,
      "p": hotelData.p,
      "lc": hotelData.lc,
      "caption": hotelData.caption,
      "ul": hotelData.ul
    };
    Navigator.of(ctx).pushNamed(Details.routeName, arguments: a);
  }

  chatNevigation(BuildContext ctx, id) {
    print("Sample text1");
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => Comment(id)));
  }

  void getColorChnange(BuildContext context) {
    setState(() {
      if (_selectedIndex == 1) {
        _selectedIndex = 0;
      } else {
        _selectedIndex = 1;
      }
      print(_selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - widget.animation.value), 0.0),
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 3),
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    widget.callback();
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            offset: const Offset(4, 4),
                            blurRadius: 7,
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                            child: Stack(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.all(5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          new Container(
                                            width: 30.0,
                                            height: 30.0,
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: new DecorationImage(
                                                fit: BoxFit.fill,
                                                image: widget.hotelData.p !=
                                                        null
                                                    ? new CachedNetworkImageProvider(
                                                        widget.hotelData.p)
                                                    : new ExactAssetImage(
                                                        'assets/images/img.jpg'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          InkWell(
                                            onTap: (){
                                              // Navigator.push(context, MaterialPageRoute(builder: (ctx) => Profile1()));
                                            },
                                            child: new Text(
                                              '${widget.hotelData.un}',
                                              overflow: TextOverflow.fade,
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    AspectRatio(
                                        aspectRatio: 1,
                                        child: InkWell(
                                          onTap: () => details(
                                              context, widget.hotelData),
                                          child: CachedNetworkImage(
                                            imageUrl: widget.hotelData.img,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              // constraints:BoxConstraints(minHeight:300),
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.scaleDown,
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                            Colors.grey,
                                                            BlendMode.dstIn)),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                Center(
                                              child: Container(
                                                height: 30,
                                                width: 30,
                                                child:
                                                    CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                Color>(
                                                          Colors.green,
                                                        ),
                                                        value: 10),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        )),
                                    Container(
                                      padding: EdgeInsets.all(0),
                                      color: HomeAppTheme.buildLightTheme()
                                          .backgroundColor,
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  InkWell(
                                                    onTap: () => likePic(
                                                        context,
                                                        widget.hotelData.ul),
                                                    child: Icon(
                                                      widget.hotelData.ul
                                                          ? FontAwesomeIcons
                                                              .solidThumbsUp
                                                          : FontAwesomeIcons
                                                              .thumbsUp,
                                                      size: 30,
                                                      color: HomeAppTheme
                                                              .buildLightTheme()
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  InkWell(
                                                    onTap: () => likeFunction(
                                                        context,
                                                        widget.hotelData.id),
                                                    child: new Text(
                                                      kFormatter(
                                                          widget.hotelData.lc),
                                                      overflow:
                                                          TextOverflow.fade,
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w200,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  InkWell(
                                                      onTap: () =>
                                                          chatNevigation(
                                                              context,
                                                              widget.hotelData
                                                                  .id),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Icon(
                                                            FontAwesomeIcons
                                                                .solidComments,
                                                            size: 20,
                                                            color: HomeAppTheme
                                                                    .buildLightTheme()
                                                                .primaryColor,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          new Text(
                                                            kFormatter(widget
                                                                .hotelData.cc),
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            textAlign:
                                                                TextAlign.right,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w200,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  Container(
                                                    child: InkWell(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(32.0),
                                                      ),
                                                      onTap: () =>
                                                          getColorChnange(
                                                              context),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 8.0,
                                                                left: 8.0,
                                                                right: 8.0),
                                                        child: _selectedIndex ==
                                                                0
                                                            ? Icon(
                                                                Icons.favorite,
                                                                color:
                                                                    Colors.red)
                                                            : Icon(
                                                                Icons
                                                                    .favorite_border,
                                                                color: Colors
                                                                    .green),
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
                                        padding: widget.hotelData.caption == ""
                                            ? EdgeInsets.all(0)
                                            : EdgeInsets.all(12),
                                        color: HomeAppTheme.buildLightTheme()
                                            .backgroundColor,
                                        child: Column(
                                          children: <Widget>[
                                            SingleChildScrollView(
                                              child: Row(
                                                children: <Widget>[
                                                  widget.hotelData.caption !=
                                                          null
                                                      ? Expanded(
                                                          child: Text(
                                                            widget.hotelData
                                                                .caption,
                                                            maxLines:
                                                                _descTextShowFlag
                                                                    ? 8
                                                                    : 2,
                                                            textAlign:
                                                                TextAlign.start,
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
                                                        )
                                                      : Container(
                                                          height: 0,
                                                        ),
                                                ],
                                              ),
                                            ),
                                            widget.hotelData.caption.length > 20
                                                ? InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        _descTextShowFlag =
                                                            !_descTextShowFlag;
                                                      });
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: <Widget>[
                                                        _descTextShowFlag
                                                            ? Text(
                                                                "Show Less",
                                                                style: TextStyle(
                                                                    color: HomeAppTheme
                                                                            .buildLightTheme()
                                                                        .primaryColor),
                                                              )
                                                            : Text("Show More",
                                                                style: TextStyle(
                                                                    color: HomeAppTheme
                                                                            .buildLightTheme()
                                                                        .primaryColor))
                                                      ],
                                                    ),
                                                  )
                                                : Container(
                                                    height: 0,
                                                    padding: EdgeInsets.all(0),
                                                  )
                                          ],
                                        ))
                                    // Padding(
                                    //    padding: EdgeInsets.all(0),
                                    // )
                                    ,
                                  ],
                                ),
                                Positioned(
                                  top: 6,
                                  right: 8,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.more_vert,
                                          size: 16,
                                          color: HomeAppTheme.buildLightTheme()
                                              .primaryColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
