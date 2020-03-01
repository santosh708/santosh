
class CommentListData {

  CommentListData({
    this.img = '',
    this.c = "", 
    this.ui,
    this.cmt="",
    this.mi,
    this.un,
    this.pimg
  });

 factory CommentListData.fromJson(Map<String, dynamic> json) {
    return CommentListData(
      img: json['img'],
      c:json['c'],
      ui:json['ui'],
      cmt:json['cmt'],
      mi:json['mi'],
      un:json['un'],
      pimg:json['pimg']
    );
  }
  String img;
  String c;
  int ui;
  String cmt;
  int mi;
  String un;
  String pimg;
 CommentListData.fromMap(Map<String, dynamic>  map) : un=map['un'],pimg=map['pimg'],mi=map['mi'],c = map['c'],img = map['img'],ui=map['ui'],cmt=map['cmt'];
  
}
