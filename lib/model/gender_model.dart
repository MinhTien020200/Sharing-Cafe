class GenderModel {
  String genderId;
  String gender;
  bool isIgnore;

  GenderModel({
    required this.genderId,
    required this.gender,
    required this.isIgnore,
  });

  factory GenderModel.fromJson(Map<String, dynamic> json) {
    return GenderModel(
        genderId: json['gender_id'],
        gender: json['gender'],
        isIgnore: json['is_ignore']);
  }
}
