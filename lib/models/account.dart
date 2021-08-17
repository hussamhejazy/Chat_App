class Account {
  late String username;
  late String email;
  late String password;

  Account();

  Account.fromMap(Map<String, dynamic> map) {
    username = map['username'];
    email = map['email'];
    password = map['password'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['username'] = username;
    map['email'] = email;
    map['password'] = password;
    return map;
  }
}
