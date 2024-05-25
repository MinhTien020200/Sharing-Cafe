class FilterModel {
  String? userId;
  bool? byProvince;
  String? provinceId;
  bool? byDistrict;
  String? districtId;
  bool? byAge;
  int? minAge;
  int? maxAge;
  bool? bySex;
  String? sexId;
  bool? byInterest;
  DateTime? createdAt;

  FilterModel({
    this.userId,
    this.byProvince,
    this.provinceId,
    this.byDistrict,
    this.districtId,
    this.byAge,
    this.minAge,
    this.maxAge,
    this.bySex,
    this.sexId,
    this.byInterest,
    this.createdAt,
  });

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    return FilterModel(
      userId: json['user_id'],
      byProvince: json['by_province'],
      provinceId: json['province_id'],
      byDistrict: json['by_district'],
      districtId: json['district_id'],
      byAge: json['by_age'],
      minAge: json['min_age'],
      maxAge: json['max_age'],
      bySex: json['by_sex'],
      sexId: json['sex_id'],
      byInterest: json['by_interest'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'by_province': provinceId != null,
      'province_id': provinceId,
      'by_district': districtId != null,
      'district_id': districtId,
      'by_age': minAge != null && maxAge != null,
      'min_age': minAge,
      'max_age': maxAge,
      'by_sex': sexId != null,
      'sex_id': sexId,
      'by_interest': byInterest,
    };
  }
}
