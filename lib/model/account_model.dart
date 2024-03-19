class AccountModel {
  final String userId;
  final String userName;
  final String token;
  final String email;

  AccountModel(
      {required this.userId,
      required this.userName,
      required this.token,
      required this.email});

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      userId: json["user_id"],
      userName: json["user_name"],
      token: json["accessToken"],
      email: json["email"],
    );
  }
}
