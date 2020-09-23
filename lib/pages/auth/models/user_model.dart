/// email : "hh@mail.com"
/// uid : "RAv3XzJWxQdWl8F1gqD9XqMIehM2"
/// username : "hh"

class UserModel {
  String email;
  String uid;
  String username;

  UserModel({this.email, this.uid, this.username});

  UserModel.map(dynamic obj) {
    this.email = obj["email"];
    this.uid = obj["uid"];
    this.username = obj["username"];
  }

  UserModel.fromJson(Map<String, dynamic> json):
    username = json['username'],
    email = json['email'],
    uid = json['uid'];

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["email"] = email;
    map["uid"] = uid;
    map["username"] = username;
    return map;
  }

}