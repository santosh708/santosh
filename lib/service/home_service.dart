import 'dart:async';
import 'dart:convert';
import 'package:best_flutter_ui_templates/model/chat_model.dart';
import 'package:best_flutter_ui_templates/model/home_list_data.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
//  const baseUrl = "http://192.168.1.15:8080";
// const baseUrl =  "https://www.b7supply.com/lsuitsocial";
const baseUrl =  "https://www.b7supply.com/lsuitsocial";
class APIHOME {
static Future fetchComent(messageId,pageNo,count) async {
 final response = await http.get('$baseUrl/api/comments/$messageId/$pageNo/$count');
final decoded = jsonDecode(response.body);
 return  decoded.map((m)=>CommentListData.fromJson(m)).toList();
 }
static Future postComment(data) async {
 final response = await http.post('$baseUrl/api/comment', headers: {"Content-Type": "application/json"},body: data);
    final decoded = jsonDecode(response.body);
 return  decoded;
 }

static likeImg(messageId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid=prefs.getInt('userid');
  final response = await http.get('$baseUrl/api/like/$messageId/$userid');
final decoded = jsonDecode(response.body);
 return  decoded;
}



static Future likeList(messageId) async {
 final response = await http.get('$baseUrl/api/likes/$messageId');
final decoded = jsonDecode(response.body);
 return  decoded.map((m)=>CommentListData.fromJson(m)).toList();
 }

static dLikeImg(messageId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid=prefs.getInt('userid');
  final response = await http.get('$baseUrl/api/dislike/$messageId/$userid');
final decoded = jsonDecode(response.body);
 return  decoded;
}

static Future fetchPost(pageNo,count) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid=prefs.getInt('userid');
 final response = await http.get('$baseUrl/api/messages/$userid/$pageNo/$count');
    final decoded = jsonDecode(response.body);
    
 return  decoded.map((m)=>HomeListData.fromJson(m)).toList();
 }
}
