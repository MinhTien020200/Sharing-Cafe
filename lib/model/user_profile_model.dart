class ProfileModel {
  final String userId;
  final String image;
  final String name;
  final String? description;
  final String gender;
  final String age;
  final String purpose;
  // final String hard;
  // final String noMention;
  // final String drinkFav;
  // final String locationFav;
  // final String freeTime;

  ProfileModel({
    required this.userId,
    required this.image,
    required this.name,
    this.description,
    required this.gender,
    required this.age,
    required this.purpose,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      userId: json["user_id"],
      image: json["profile_avatar"],
      name: json["user_name"],
      description: json["story"],
      gender: json["gender"],
      age: json["age"],
      purpose: json["purpose"],
    );
  }
}
