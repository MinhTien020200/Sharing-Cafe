class AccountModel {
  final String userId;
  final String userName;
  final String token;
  final String email;
  final String password;
  final String phone;
  final String profileAvatar;
  final String bio;
  final String registration;
  final String interestName;

  AccountModel(
      {required this.userId,
      required this.userName,
      required this.token,
      required this.email,
      required this.password,
      required this.phone,
      required this.profileAvatar,
      required this.bio,
      required this.registration,
      required this.interestName});

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      userId: json["user_id"],
      userName: json["user_name"],
      token: json["accessToken"],
      email: json["email"],
      password: json["password"],
      phone: json["phone"],
      profileAvatar: json["profile_avatar"],
      bio: json["bio"],
      registration: json["registration"],
      interestName: json["interest_name"],
    );
  }
}
