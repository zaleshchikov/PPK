class User {
  String email;
  String password;
  String nickName;
  String token;

  User(this.email, this.nickName, this.password, this.token);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "email": email,
      "password": password,
      "token": token,
      "nickname": nickName
    };
  }

  static User fromMap(Map map) {
    return User(map['email'], map['nickname'], map['password'], map['token']);
  }
}
