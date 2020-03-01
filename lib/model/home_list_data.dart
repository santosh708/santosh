
class HomeListData {
  HomeListData({
    this.img = '',
    this.id=0,
    this.un="",
    this.t = '',
    this.subTxt = "dfdfdfdfdfdf",
    this.dist = 1.8,
    this.cc=0, 
    this.lc = 0,
    this.p, 
    this.caption ='',
    this.ul=false
  });

 factory HomeListData.fromJson(Map<String, dynamic> json) {
    return HomeListData(
      img: json['img'],
      t: json['t'],
      id:json['id'],
      un:json['un'],
      p:json['p'],
      cc:json['cc'],
      lc:json['lc'],
      caption: json['msg'],
      ul:json['ul']
    );
  }
  int id;
  String img;
  String t;
  String subTxt;
  double dist;
  int cc;
  int lc;
  String caption;
  String un;
  String p;
  bool ul;
 HomeListData.fromMap(Map<String, dynamic>  map) :p=map['p'],caption=map['msg'],un=map['un'],id = map['id'],img = map['img'],t = map['t'];
  
}
