class User {
  String username;
  String password;
  String name;

  User({required this.username, required this.password, required this.name});
  
 User.fromMap(Map<String, dynamic> map)
      : username = map['username'],
        password = map['password'],
        name = map['name'];

      String get getUsername => username;
      String get getPassword => password;
      String get getName => name;

      Map<String, dynamic> toMap() {
        return {
          'username': username,
          'password': password,
          'name': name,
        };
      }
}
