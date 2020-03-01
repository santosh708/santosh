import 'dart:async';
import 'dart:convert';
import 'package:best_flutter_ui_templates/model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
  //const baseUrl = "http://192.168.1.15:8080";
// const baseUrl = "https://www.b7supply.com/lonarSocialApp";
//const baseUrl = "http://192.168.1.83:8080/lonarsocialapp";
const baseUrl =  "https://www.b7supply.com/lsuitsocial";
class LoginApi {

static Future postOtp(data) async {
  var a={
    "username":data
  };

 final response = await http.post('$baseUrl/api/sendotp', headers: {"Content-Type": "application/json"},body: jsonEncode(a));
    final decoded = jsonDecode(response.body) ;
   
    print(decoded);
 return  decoded;
 }


 static Future getValidate(data) async {
 SharedPreferences prefs = await SharedPreferences.getInstance();
 final response = await http.post('$baseUrl/api/login', headers: {"Content-Type": "application/json"},body: jsonEncode(data));
Map data1 = jsonDecode(response.body);
// data1['data'];
print(data1['data']['userid']);
LoginModel loginModel=new LoginModel();
  loginModel.userid=data1['data']['userid'];
  loginModel.username=data1['data']['username'];
prefs.setInt('userid', data1['data']['userid']);
prefs.setString('userName', data1['data']['username']);
prefs.setString('firstname', data1['data']['firstname']);
prefs.setString('lastname', data1['data']['lastname']);
prefs.setString('empNo', data1['data']['empNo']);
prefs.setString('mob', data1['data']['mob']);
 return   LoginModel.fromJson(data1['data']);
 }


 static Future getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid=prefs.getInt('userid');
final response = await http.get('$baseUrl/api/user/$userid');
Map data1 = jsonDecode(response.body);
return data1['data'];
 }


  static Future getUserData1(userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid=prefs.getInt('userid');
final response = await http.get('$baseUrl/api/user/$userid');
Map data1 = jsonDecode(response.body);
return data1['data'];
 }
}
