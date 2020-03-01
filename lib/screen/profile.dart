import 'dart:convert';
import 'dart:io';
import 'package:best_flutter_ui_templates/screen/home_screen.dart';
import 'package:best_flutter_ui_templates/service/login_service.dart';
import 'package:best_flutter_ui_templates/widget/appBar1.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/ProfilePage';
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>

    with SingleTickerProviderStateMixin {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool _status = false;
  File _imageFile;
  ProgressDialog pr;
  var intialValue;
  bool status = false;
  int userid;
  var data;
  bool imageFlag = false;
  final FocusNode myFocusNode = FocusNode();
  void initState() {
    LoginApi.getUserData().then((value) => {
          // print(value.firstname),
          setState(() {
            status = true;
            _status = false;
            if (value['fristname'] == null) {
              data = value;
              data['mob'] = data['username'];
            } else {
              data = value;
              _imageFile = data['profilePic'];
            }

            print("santosh zanak");
            print("====>$data");
          })
        });
    super.initState();
  }

  @override
  Future<bool> _onBackPressed() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('firstname') == null) {
    } else {
      Navigator.pushNamed(context, HomeScreen.routeName);
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    void _getImage(BuildContext ctx, imageSource) async {
      try {
        File image = await ImagePicker.pickImage(
            source: imageSource,
            maxHeight: 900,
            imageQuality: 100,
            maxWidth: 800);

        File croppedFile = await ImageCropper.cropImage(
            sourcePath: image.path,
            aspectRatioPresets: Platform.isAndroid
                ? [
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.ratio5x4,
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio16x9,
                    CropAspectRatioPreset.ratio7x5,
                  ]
                : [
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio5x3,
                    CropAspectRatioPreset.ratio5x4,
                    CropAspectRatioPreset.ratio7x5,
                    CropAspectRatioPreset.ratio16x9
                  ],
            androidUiSettings: AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.square,
                lockAspectRatio: false),
            iosUiSettings: IOSUiSettings(
              title: 'Cropper',
            ));
        if (croppedFile != null) {
          setState(() {
            image = croppedFile;
          });
        }

        setState(() {
          _imageFile = image;
          imageFlag = true;
          data['profilePic'] = _imageFile.path;
        });
      } catch (_) {}
      setState(() {
        Navigator.of(context).pop();
      });
    }

    void _openImagePickerModal(BuildContext context) {
      final flatButtonColor = Theme.of(context).primaryColor;
      print('Image Picker Modal Called');
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 80.0,
              color: Colors.transparent,
              // padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    textColor: flatButtonColor,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Camera",
                          ),
                          WidgetSpan(
                            child: Icon(Icons.camera_alt, size: 30),
                          ),
                          // TextSpan(
                          //   text: " to add",
                          // ),
                        ],
                      ),
                    ),

                    //Text('Use Camera'),
                    onPressed: () {
                      _getImage(context, ImageSource.camera);
                    },
                  ),
                  FlatButton(
                    textColor: flatButtonColor,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Gallery",
                          ),
                          WidgetSpan(
                            child: Icon(Icons.camera, size: 30),
                          ),
                          // TextSpan(
                          //   text: " to add",
                          // ),
                        ],
                      ),
                    ),
                    //Text('Use Gallery'),
                    onPressed: () {
                      _getImage(context, ImageSource.gallery);
                    },
                  ),
                ],
              ),
            );
          });
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(
        body: status
            ? new Container(
                color: Colors.white,
                child: new ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        new Container(
                          height: 250.0,
                          color: Colors.white,
                          child: new Column(
                            children: <Widget>[
                              GetAppBarUI1("Profile", true),
                              Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: new Stack(
                                    fit: StackFit.loose,
                                    children: <Widget>[
                                      new Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          ClipOval(
                                              child: _imageFile != null
                                                  ? Image.file(_imageFile,
                                                      height: 140,
                                                      width: 140,
                                                      fit: BoxFit.cover)
                                                  : data['profilePic'] == null
                                                      ? Image.asset(
                                                          "assets/images/img.jpg",
                                                          height: 140,
                                                          width: 140,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Image(
                                                          image: CachedNetworkImageProvider(
                                                              data[
                                                                  'profilePic']),
                                                          height: 140,
                                                          width: 140,
                                                          fit: BoxFit.cover,
                                                        ))
                                        ],
                                      ),
                                      _status
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  top: 90.0, right: 100.0),
                                              child: new Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  new CircleAvatar(
                                                    backgroundColor: Colors.red,
                                                    radius: 25.0,
                                                    child: InkWell(
                                                      onTap: () =>
                                                          _openImagePickerModal(
                                                              context),
                                                      child: new Icon(
                                                        Icons.camera_alt,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ))
                                          : Container(),
                                    ]),
                              )
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Personal Information',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    !_status ? _getEditIcon() : new Container(),
                                  ],
                                )
                              ],
                            )),
                        FormBuilder(
                          key: _fbKey,
                          autovalidate: false,
                          initialValue: data,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: FormBuilderTextField(
                                          textCapitalization:
                                              TextCapitalization.words,
                                          attribute: "firstname",
                                          autovalidate: true,
                                          autofocus: true,
                                          
                                          autocorrect: true,
                                          readOnly: !_status,
                                          decoration: InputDecoration(
                                              labelText: "first Name"),
                                          validators: [
                                            FormBuilderValidators.required(),
                                            // FormBuilderValidators.max(70),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: FormBuilderTextField(
                                          textCapitalization:
                                              TextCapitalization.words,
                                               autovalidate: true,
                                          autofocus: true,
                                          autocorrect: true,
                                          attribute: "lastname",
                                          decoration: InputDecoration(
                                              labelText: "Last Name"),
                                          readOnly: !_status,
                                          validators: [
                                            FormBuilderValidators.required(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: FormBuilderTextField(
                                          attribute: "empNo",
                                          readOnly: !_status,
                                          decoration: InputDecoration(
                                              labelText: "Emp No"),
                                         
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: FormBuilderTextField(
                                          attribute: "mob",
                                          readOnly: true,
                                           autovalidate: true,
                                          autofocus: true,
                                          autocorrect: true,
                                          decoration: InputDecoration(
                                              labelText: "mobile No"),
                                          validators: [
                                            FormBuilderValidators.numeric(),
                                            FormBuilderValidators.required(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: FormBuilderTextField(
                                          attribute: "email",
                                          autovalidate: true,
                                          autofocus: true,
                                          
                                          autocorrect: true,
                                         
                                          readOnly: !_status,
                                          decoration: InputDecoration(
                                              labelText: "Email"),
                                          validators: [
                                            
                                            FormBuilderValidators.email(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _status
                            ? Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        child: new RaisedButton(
                                      child: new Text("Save"),
                                      textColor: Colors.white,
                                      color: Colors.green,
                                      onPressed: () async {
                                        pr.show();
                                        if (_fbKey.currentState
                                            .saveAndValidate()) {

                                          if (_imageFile != null) {
                                            final bytes =
                                                await _imageFile.readAsBytes();
                                            print(
                                                "Picture original size:  ${bytes.length / 104857}");
                                            print(_imageFile.length());

                                            print("santosh");
                                            File compressedFile =
                                                await FlutterNativeImage
                                                    .compressImage(
                                                        _imageFile.path,
                                                        percentage: 100);

                                            final bytes1 = await compressedFile
                                                .readAsBytes();
                                            print(
                                                "Picture commress image  size:  ${bytes1.length / 104857}");

                                            print(_fbKey.currentState.value);
                                            print(_imageFile.path);
                                            final imageUploadRequest =
                                                http.MultipartRequest(
                                              'POST',
                                              Uri.parse(
                                                  "https://www.b7supply.com/lsuitsocial/api/userwithprofile"),
                                            );

                                            final file = await http
                                                    .MultipartFile
                                                .fromPath(
                                                    'file', _imageFile.path);
                                            imageUploadRequest.files.add(file);

                                            imageUploadRequest.fields['user'] =
                                                json.encode(
                                                    _fbKey.currentState.value);
                                            try {
                                              final streamedResponse =
                                                  await imageUploadRequest
                                                      .send();
                                              final response = await http
                                                      .Response
                                                  .fromStream(streamedResponse);
                                              print(response.toString());
                                              final Map<String, dynamic>
                                                  responseData =
                                                  json.decode(response.body);
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              print(
                                                  "responseData=============>$responseData");
                                              if (response.statusCode == 200) {
                                                prefs.setString(
                                                    'userName',
                                                    responseData['data']
                                                        ['username']);
                                                prefs.setString(
                                                    'firstname',
                                                    responseData['data']
                                                        ['firstname']);
                                                prefs.setString(
                                                    'lastname',
                                                    responseData['data']
                                                        ['lastname']);
                                                prefs.setString(
                                                    'empNo',
                                                    responseData['data']
                                                        ['empNo']);
                                                prefs.setString(
                                                    'mob',
                                                    responseData['data']
                                                        ['mob']);
                                                Toast.show(
                                                    "sucessFully upload..!",
                                                    context,
                                                    duration:
                                                        Toast.LENGTH_SHORT,
                                                    gravity: Toast.BOTTOM);
                                                Navigator.of(context).pushNamed(
                                                    HomeScreen.routeName);
                                                return responseData;
                                              }

                                              print(response.statusCode);
                                              return responseData;
                                            } catch (e) {
                                              print("sddsds");
                                              print(e);
                                              return e;
                                            }
                                          } else {
                                            final response = await http.post(
                                                "https://www.b7supply.com/lsuitsocial/api/user",
                                                headers: {
                                                  "Content-Type":
                                                      "application/json"
                                                },
                                                body: json.encode(
                                                    _fbKey.currentState.value));
                                            final decoded =
                                                jsonDecode(response.body);
                                            if (response.statusCode == 200) {
                                              Navigator.of(context).pushNamed(
                                                  HomeScreen.routeName);
                                            }
                                          }
                                        }
                                        setState(() {
                                          _status = true;
                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode());
                                        });
                                      },
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(20.0)),
                                    )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        child: new RaisedButton(
                                      child: new Text("Reset"),
                                      textColor: Colors.white,
                                      color: Colors.red,
                                      onPressed: () {
                                        _fbKey.currentState.reset();
                                        setState(() {
                                          _status = true;
                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode());
                                        });
                                      },
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(20.0)),
                                    )),
                                  ],
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ],
                ),
              )
            : Container(),
      ),
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = true;
        });
      },
    );
  }
}
