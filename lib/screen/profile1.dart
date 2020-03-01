import 'package:best_flutter_ui_templates/service/login_service.dart';
import 'package:best_flutter_ui_templates/theam/home_app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

List<Song> songs = [
  Song('Behaviour of the mind', '3:25'),
  Song('Your inner voice', '2:41'),
  Song('Embrace your emotions', '3:16'),
  Song('Letting go everything', '3:38'),
  Song('Feel the sky', '2:56'),
  Song('Go beyond the form', '3:24'),
  Song('Love the feelings', '3:44'),
];

class Song {
  final String name;
  final String time;

  Song(this.name, this.time);
}

class Profile1 extends StatefulWidget {
  static const routeName = '/Profile1';
  int userId = 20;
  // Profile1(int userId){
  //  userId=20;
  // }
  @override
  @override
  _Profile1State createState() => _Profile1State();
}

class _Profile1State extends State<Profile1> {
  var data;
  bool status;
  void initState() {
    LoginApi.getUserData1(20).then((value) => {
          // print(value.firstname),
          setState(() {
            status = true;

            data = value;
            data['mob'] = data['username'];
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      HeaderBackground(),
                      Container(
                        // alignment: Alignment.center,
                        height: 350,
                        padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white54,
                                  ),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.share,
                                    color: Colors.white54,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            // SizedBox(height: 15),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: data['firstname'],
                                  style: TextStyle(fontSize: 35),
                                  children: <TextSpan>[
                                    TextSpan(style: TextStyle(fontSize: 35)),
                                    TextSpan(
                                        text: data['lastname'],
                                        style: TextStyle(fontSize: 35))
                                  ]),
                            ),

                            Text(
                              data['username'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              data['email'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            // Container(
                            //   // margin: EdgeInsets.only(top: 25),
                            //   width: 150,
                            //   // height: 2,
                            //   decoration: BoxDecoration(
                            //     gradient: LinearGradient(
                            //       begin: Alignment.centerLeft,
                            //       end: Alignment.centerRight,
                            //       colors: [
                            //         Colors.grey.withOpacity(0.05),
                            //         Colors.grey.withOpacity(0.5),
                            //         Colors.grey.withOpacity(0.05),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Container(
                        child: ClipOval(
                            child: Image(
                          image: CachedNetworkImageProvider(data['profilePic']),
                          // height: 140,
                          width: 140,
                          fit: BoxFit.cover,
                        )),
                        width: 150,
                        // height: 150,
                        margin: EdgeInsets.only(top: 205),
                        decoration: BoxDecoration(
                          // image: DecorationImage(
                          //     image: data['profilePic'] != null
                          //         ? NetworkImage(data['profilePic'], scale: 01)
                          //         : AssetImage("assets/images/img.jpg")),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      )
                    ],
                  ),
                  // Container(
                  //   height: listheight,
                  //   padding: EdgeInsets.symmetric(horizontal: 35),
                  //   margin: EdgeInsets.only(bottom: 130),
                  //   child: ListView.builder(
                  //     physics: NeverScrollableScrollPhysics(),
                  //     itemCount: songs.length,
                  //     itemExtent: 45,
                  //     itemBuilder: (context, index) => ListTile(
                  //       leading: Icon(
                  //           index == 0 ? Icons.play_arrow : Icons.lock_outline,
                  //           size: 22),
                  //       title: Text(songs[index].name, style: TextStyle(fontSize: 14)),
                  //       trailing:
                  //           Text(songs[index].time, style: TextStyle(fontSize: 14)),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
            // CustomBottomBar(),
            // PlayButton(),
          ],
        ),
      ),
    );
  }
}

// class MeditationScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:
//     );
//   }
// }

class CustomBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      width: MediaQuery.of(context).size.width,
      child: IgnorePointer(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.white,
                    Colors.white,
                    Colors.white.withOpacity(0.01),
                  ],
                ),
              ),
            ),
            ClipPath(
              clipper: BottomBarClipper(),
              child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.blueGrey.shade800,
                      Colors.blueGrey.shade800,
                      Colors.blue.shade800,
                      Colors.blue.shade300,
                      Colors.white,
                      Colors.white,
                    ],
                  ),
                ),
                child: ClipPath(
                  clipper: BottomBarClipper(),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    height: double.infinity,
                    padding: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.blueGrey.shade100,
                          Colors.blueGrey.shade100,
                          Colors.white,
                          Colors.white,
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          '2.30',
                          style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Rainforest - Relaxing',
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '-0.50',
                          style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 55,
      left: MediaQuery.of(context).size.width / 2 - 30,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blueGrey.shade900,
              Colors.blue.shade700,
            ],
          ),
        ),
        child: IconButton(
          onPressed: () {},
          icon: Icon(Icons.play_arrow,
              color: Colors.white.withOpacity(0.9), size: 40),
        ),
      ),
    );
  }
}

class HeaderBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          width: 100,
          height: 140,
          margin: EdgeInsets.only(top: 205),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                blurRadius: 0, spreadRadius: 0, color: Colors.blueGrey.shade800)
          ]),
        ),
        ClipPath(
          clipper: HeaderClipper(),
          child: Container(
            margin: EdgeInsets.only(top: 5),
            height: 350,
            color: HomeAppTheme.buildLightTheme().primaryColor,
          ),
        ),
        ClipPath(
          clipper: HeaderClipper(),
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/city.png'), fit: BoxFit.cover),
            ),
          ),
        ),
      ],
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    var sw = size.width;
    var sh = size.height;

    path.lineTo(sw, 0);
    path.lineTo(sw, sh);
    path.cubicTo(sw, sh * 0.7, 0, sh * 0.8, 0, sh * 0.55);
    path.lineTo(0, sh);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BottomBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    var sw = size.width;
    var sh = size.height;

    path.lineTo(4 * sw / 12, 0);
    path.cubicTo(
        5 * sw / 12, 0, 5 * sw / 12, 2 * sh / 5, 6 * sw / 12, 2 * sh / 5);
    path.cubicTo(7 * sw / 12, 2 * sh / 5, 7 * sw / 12, 0, 8 * sw / 12, 0);
    path.lineTo(sw, 0);
    path.lineTo(sw, sh);
    path.lineTo(0, sh);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
