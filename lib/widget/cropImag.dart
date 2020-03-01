import 'dart:convert';
import 'dart:math';
import 'package:best_flutter_ui_templates/screen/home_screen.dart';
import 'package:best_flutter_ui_templates/screen/login.dart';
import 'package:best_flutter_ui_templates/widget/appBar1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;
import 'package:image/image.dart' as Im;
class ImageCrop extends StatefulWidget {
  static const routeName = '/ImageCrop';
  File imageFile,compressedImage;
  ImageCrop(File imageFile) {
    this.imageFile = imageFile;
  }
  @override
  _ImageCropState createState() => _ImageCropState();
}
enum AppState {
  free,
  picked,
  cropped,
}
class _ImageCropState extends State<ImageCrop> {
  AppState state;
  int ui;
   ProgressDialog pr;
   final _random = new Random();
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      ui = prefs.getInt('userid');
      print("asasasa====>$ui");
      state = AppState.cropped;
      _cropImage();
    });
  }
  @override
  void initState() {
    super.initState();
    getData();
    print("FILE SIZE BEFORE: " + widget.imageFile.lengthSync().toString());
    state = AppState.picked;
  }
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
 //  String baseUrl="http://192.168.1.15:8080/api/upload";
String baseUrl="https://www.b7supply.com/lsuitsocial/api/upload";
         Future _uploadImage(File image) async {
           await pr.show();
        if (_fbKey.currentState.saveAndValidate()) {
      final imageUploadRequest = http.MultipartRequest(
        'POST',
        Uri.parse(baseUrl),
      );

  
  final bytes = await widget.imageFile.readAsBytes();
  print("Picture commress image  size:  ${bytes.length/104857}");
    double a= ( bytes.length * 100) / 1048576;
 



File compressedImage;
if(bytes.length >= 1048576-10){
       final tempDir = await getTemporaryDirectory();
     final path = tempDir.path;
     int rand = _random.nextInt(10000);
     Im.Image image = Im.decodeImage(widget.imageFile.readAsBytesSync());
    //  Im.Image smallerImage = Im.copyResize(image, width: 500);
     widget.imageFile = new File('$path/img_$rand.jpg')
       ..writeAsBytesSync(Im.encodeJpg(image, quality: 50));
}

 final bytes11 = await widget.imageFile.readAsBytes();
  print("Picture commress image  size1111:  ${bytes11.length/104857}");
      final file = await http.MultipartFile.fromPath('file',widget.imageFile.path);
      imageUploadRequest.files.add(file);
      imageUploadRequest.fields['message'] = json.encode(_fbKey.currentState.value);
      try {
        if(ui!=null){
      final streamedResponse = await imageUploadRequest.send();
        final response = await http.Response.fromStream(streamedResponse);
        print(response.toString());
        final Map<String, dynamic> responseData = json.decode(response.body);
        print(response);
        if (response.statusCode == 200) {
          Toast.show("sucessFully upload..!",context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
            Navigator.of(context).pushNamed(HomeScreen.routeName);
          return responseData;
        }
        print(response.statusCode);
        return responseData;
        }else{
              Navigator.popAndPushNamed(context, LoginPage.routeName);
        }
      
      } catch (e) {
        print(e);
        return e;
      }
    }
    }
//   Future<bool> _onBackPressed() {
// Navigator.pushNamed(context, HomeScreen.routeName);
// }
    return Scaffold(
      body: new Container(
        color: Colors.white,
        child: new ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                GetAppBarUI1("Image Edit", true),
                FormBuilder(
                  key: _fbKey,
                  initialValue: {
                    "ui": ui
                    },
                  autovalidate: false,
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
                                  attribute: "t",
                                  decoration:
                                      InputDecoration(labelText: "Title"),
                                  // validators: [
                                  //   FormBuilderValidators.required(),
                                  //   // FormBuilderValidators.max(70),
                                  // ],
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
                                  attribute: "msg",
                                  decoration: InputDecoration(labelText: "Capation"),
                                  // validators: [
                                  //   FormBuilderValidators.required(),
                                  // ],
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 500,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  child: Image.file(widget.imageFile)
                  ),
              ],
            ),
          ],
        ),
      ),
                floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton.extended(
              label: Text("Upload"),
              onPressed: () => _uploadImage(widget.imageFile),
              heroTag: UniqueKey(),
              icon: Icon(Icons.file_upload),
            ),
            SizedBox(
              width: 20,
            ),
            FloatingActionButton.extended(
              label: Text(
                "Edit",
              ),
              onPressed: () => {
                 if (state == AppState.free)
              _pickImage()
            else if (state == AppState.picked)
              _cropImage()
            else if (state == AppState.cropped)
              // _clearImage();
              _cropImage()
              },
              heroTag: UniqueKey(),
              icon: Icon(Icons.crop),
            )
          ],
        )
    );
  }

  Future<Null> _pickImage() async {
    widget.imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (widget.imageFile != null) {
      setState(() {
        state = AppState.picked;
      });
    }
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: widget.imageFile.path,
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
      widget.imageFile = croppedFile;
      setState(() {
        state = AppState.cropped;
      });
    }
  }

  // void _clearImage() {
  //   //   widget.imageFile = null;
  //   //   setState(() {
  //   //     state = AppState.free;
  //   //   });
  // }
}
