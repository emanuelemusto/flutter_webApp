class User {
  String username;
  String role;
  int token;
  int id;

  User({this.username, this.role, this.token, this.id});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    role = json['role'];
    token = json['token'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['id'] = this.role;
    data['token'] = this.token;
    data['idp'] = this.id;
    return data;
  }
}
