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
      'userId': userId,
      'byProvince': provinceId != null,
      'provinceId': provinceId,
      'byDistrict': districtId != null,
      'districtId': districtId,
      'byAge': minAge != null && maxAge != null,
      'minAge': minAge,
      'maxAge': maxAge,
      'bySex': sexId != null,
      'sexId': sexId,
      'byInterest': byInterest,
    };
  }
}
