class LoginModel {
  int userid;
  String username;
  String firstname;
  String lastname;
  String mob;
  LoginModel(
      {this.userid, this.username, this.firstname, this.lastname, this.mob});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
        userid: json['userid'],
        username: json['username'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        mob: json['mob']);
  }
}
