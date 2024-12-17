class UserModel {
  final String email;
  final String name;
  final String role;
  final String profilePicUrl;

  UserModel(
      {required this.email,
      required this.name,
      required this.role,
      required this.profilePicUrl});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      name: map['displayname'] as String,
      role: map['role'] as String,
      profilePicUrl: map['profile_pic_url'] as String,
    );
  }
}
