class User {
  String username;
  String role;
  int token;

  User({
    this.username,
    this.role,
    this.token,
  });

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    role = json['role'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['id'] = this.role;
    data['token'] = this.token;
    return data;
  }
}
