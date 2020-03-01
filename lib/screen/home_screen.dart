import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:best_flutter_ui_templates/screen/profile.dart';
import 'package:best_flutter_ui_templates/service/home_service.dart';
import 'package:best_flutter_ui_templates/theam/home_app_theme.dart';
import 'package:best_flutter_ui_templates/widget/appBar1.dart';
import 'package:best_flutter_ui_templates/widget/cropImag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:minimize_app/minimize_app.dart';
import 'filters_screen.dart';
import 'hotel_list_view.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController animationController;
  int _index1 = 1;
  int _selectedItemPosition = 2;
  List<dynamic> _homelList = [];
  String _title = "Lonar Social";
  ScrollController _scrollController = ScrollController();
  File _imageFile;
  bool _loadingMore=true;
  bool _refreshFlag=false;
  //============================== Image from gallery
  void _openImagePickerModal(BuildContext context) {
    final flatButtonColor = Theme.of(context).primaryColor;
    print('Image Picker Modal Called');
     showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Pick an image',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Use Camera'),
                  onPressed: () {
                    _getImage(context, ImageSource.camera);
                  },
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Use Gallery'),
                  onPressed: () {
                    _getImage(context, ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }

  // ================================= _getImage
  void _getImage(BuildContext ctx, ImageSource source) async {
    try {
      File image = await ImagePicker.pickImage(source: source);
      _imageFile = image;
      _imageFile = image;
      if (_imageFile != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (ctx) => ImageCrop(_imageFile)));
      } else {
        setState(() {
           _selectedItemPosition=2;
        });
       
      }
    } catch (_) {
    setState(() {
           _selectedItemPosition=2;
        });
    }
 
  }

//========================
  initState() {
    print("Sample text1");
    APIHOME.fetchPost(1, 10).then((response) {
      setState(() {
        _loadingMore=false;
        _homelList = List.from(response);
        // Toast.show(_homelList.toString(),context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
      });
    });

    //=============================================
    _scrollController.addListener(() {
      print(_scrollController.position.pixels);
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
           
        _getMoreData();
      }else if(_scrollController.position.pixels ==
          _scrollController.position.minScrollExtent){
            setState(() {
               _refreshFlag=true;
            });
         
             
     APIHOME.fetchPost(1, 10).then((response) {
      setState(() {
         Timer(Duration(seconds: 10), () {
        
      });
          setState(() {
            
               _refreshFlag=false;
               _homelList = List.from(response);
            });
        
        // Toast.show(_homelList.toString(),context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
      });

});

      }
    });

    animationController = AnimationController(
        duration: const Duration(milliseconds: 2), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 2));
    return true;
  }

  _getMoreData() {
    setState(() {
       _loadingMore = true;
    });
    
    _index1 = _index1 + 1;
    APIHOME.fetchPost(_index1, 10).then((response) {
      setState(() {   
     Timer(Duration(seconds: 10), () {
        
      });
       _homelList.addAll(response);
       _loadingMore = false;
     });
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  getMinmize() {
    Navigator.of(context).pop(false);
    MinimizeApp.minimizeApp();
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => getMinmize(),
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
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
                      GetAppBarUI1(_title, false),
                        _refreshFlag ? Container(
                          padding: EdgeInsets.all(10),
                        color: Colors.white,
                        child: Center(
                        child: 
                    
                       CircularProgressIndicator()
                        ),
                      ):Container(),
                      Container(
                        child: Expanded(
                          child: NestedScrollView(
                            headerSliverBuilder:
                                (BuildContext context, bool innerBoxIsScrolled) {
                              return <Widget>[
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: <Widget>[
                                        // Search(),
                                        // getTimeDateUI(),
                                      ],
                                    );
                                  }, childCount: 1),
                                ),
                                // SliverPersistentHeader(
                                //   pinned: true,
                                //   floating: true,
                                //   delegate: ContestTabHeader(
                                //     // getFilterBarUI(),
                                //   ),
                                // ),
                              ];
                            },
                            body: Container(
                              color:
                                  HomeAppTheme.buildLightTheme().backgroundColor,
                              child: ListView.builder(
                                controller: _scrollController,
                                physics: ScrollPhysics(),
                                
                                itemCount: _homelList.length,
                                padding: const EdgeInsets.only(top: 0),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  final int count = _homelList.length;
                                  final Animation<double> animation =
                                      Tween<double>(begin: 0.0, end: 1.0).animate(
                                          CurvedAnimation(
                                              parent: animationController,
                                              curve: Interval(
                                                  (1 / count) * index, 1.0,
                                                  curve: Curves.fastOutSlowIn)));
                                  animationController.forward();
                                  return HotelListView(
                                    callback: () {},
                                    hotelData: _homelList[index],
                                    animation: animation,
                                    animationController: animationController,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                     _loadingMore ?
                      Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                        child: Center(
                        child: 
                    
                        CircularProgressIndicator()
                        ),
                      ):Container(),
                    ],
                  ),
                ),
              ],
            ),
     
            bottomNavigationBar: SnakeNavigationBar(
              currentIndex: _selectedItemPosition,
              shadowColor: Colors.red,
              onPositionChanged: (index) =>  {
                    if (index == 1)
                      {_getImage(context, ImageSource.camera)}
                    else if (index == 3)
                      {_getImage(context, ImageSource.gallery)}
                      else if(index==4){
                            Navigator.pushNamed(context, ProfilePage.routeName)
                             
                      },},
                  
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border), title: Text('Favorite')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.camera_alt), title: Text('Camera')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), title: Text('home')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.camera), title: Text('camera')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), title: Text('Profile'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getListUI() {
    return Container(
      decoration: BoxDecoration(
        color: HomeAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, -2),
              blurRadius: 8.0),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 156 - 50,
            child: FutureBuilder<bool>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  return ListView.builder(
                    itemCount: _homelList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final int count =
                          _homelList.length > 10 ? 10 : _homelList.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animationController,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                      animationController.forward();

                      return HotelListView(
                        callback: () {},
                        hotelData: _homelList[index],
                        animation: animation,
                        animationController: animationController,
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget getHotelViewList() {
    final List<Widget> hotelListViews = <Widget>[];
    for (int i = 0; i < _homelList.length; i++) {
      final int count = _homelList.length;
      final Animation<double> animation =
          Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );
      hotelListViews.add(
        HotelListView(
          callback: () {},
          hotelData: _homelList[i],
          animation: animation,
          animationController: animationController,
        ),
      );
    }
    animationController.forward();
    return Column(
      children: hotelListViews,
    );
  }

  // Widget getTimeDateUI() {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 18, bottom: 16),
  //     child: Row(
  //       children: <Widget>[
  //         Padding(
  //           padding: const EdgeInsets.only(right: 8),
  //           child: Container(
  //             width: 1,
  //             height: 42,
  //             color: Colors.grey.withOpacity(0.8),
  //           ),
  //         ),
  //         Expanded(
  //           child: Row(
  //             children: <Widget>[
  //               Material(
  //                 color: Colors.transparent,
  //                 child: InkWell(
  //                   focusColor: Colors.transparent,
  //                   highlightColor: Colors.transparent,
  //                   hoverColor: Colors.transparent,
  //                   splashColor: Colors.grey.withOpacity(0.2),
  //                   borderRadius: const BorderRadius.all(
  //                     Radius.circular(4.0),
  //                   ),
  //                   onTap: () {
  //                     FocusScope.of(context).requestFocus(FocusNode());
  //                   },
  //                   child: Padding(
  //                     padding: const EdgeInsets.only(
  //                         left: 8, right: 8, top: 4, bottom: 4),
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: <Widget>[
  //                         Text(
  //                           'Number of Rooms',
  //                           style: TextStyle(
  //                               fontWeight: FontWeight.w100,
  //                               fontSize: 16,
  //                               color: Colors.grey.withOpacity(0.8)),
  //                         ),
  //                         const SizedBox(
  //                           height: 8,
  //                         ),
  //                         Text(
  //                           '1 Room - 2 Adults',
  //                           style: TextStyle(
  //                             fontWeight: FontWeight.w100,
  //                             fontSize: 16,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget getFilterBarUI() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: HomeAppTheme.buildLightTheme().backgroundColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, -2),
                    blurRadius: 8.0),
              ],
            ),
          ),
        ),
        Container(
          color: HomeAppTheme.buildLightTheme().backgroundColor,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 2),
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => FiltersScreen(),
                            fullscreenDialog: true),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Filtter',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.sort,
                                color: HomeAppTheme.buildLightTheme()
                                    .primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('_homelList', _homelList));
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
  );
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
