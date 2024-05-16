class ProvinceModel {
  String provinceId;
  String province;

  ProvinceModel({
    required this.provinceId,
    required this.province,
  });

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    return ProvinceModel(
      provinceId: json['province_id'],
      province: json['province'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProvinceModel &&
          runtimeType == other.runtimeType &&
          provinceId == other.provinceId &&
          province == other.province;

  @override
  int get hashCode => provinceId.hashCode ^ province.hashCode;
}

class DistrictModel {
  String id;
  String fullName;

  DistrictModel({
    required this.id,
    required this.fullName,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
      id: json['district_id'],
      fullName: json['district'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DistrictModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          fullName == other.fullName;

  @override
  int get hashCode => id.hashCode ^ fullName.hashCode;
}
