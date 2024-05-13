class UserModel {
  final String email;
  final String password;

  UserModel({
    required this.email,
    required this.password,
  });

  bool validate() {
    if (email == 'admin@gmail.com' && password == 'admin') {
      return true;
    }
    return false;
  }
}
