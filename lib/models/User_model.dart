class UserModel {
  final String? UserId;
  final String name;
  final String email;
  final String password;
  UserModel({
    this.UserId,
    required this.email,
    required this.name,
    required this.password,
  });
}
