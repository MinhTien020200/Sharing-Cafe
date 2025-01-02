import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:sharing_cafe/helper/api_helper.dart';
import 'package:sharing_cafe/helper/error_helper.dart';
import 'package:sharing_cafe/helper/location_helper.dart';
import 'package:sharing_cafe/helper/shared_prefs_helper.dart';
import 'package:sharing_cafe/model/province_model.dart';

class LocationService {
  Future updateLocation() async {
    // update current location to backend
    var userId = await SharedPrefHelper.getUserId();
    if (userId.isNotEmpty) {
      var currentLocation = await LocationHelper.getCurrentLocation();
      var endpoint =
          "/location/updateCurrentLocation?userId=$userId&e&lat=${currentLocation.latitude}&lng=${currentLocation.longitude}";
      var response = await ApiHelper().put(endpoint, {});
      if (response.statusCode == HttpStatus.ok) {
        if (kDebugMode) {
          print("Update location success");
        }
        return true;
      } else {
        ErrorHelper.showError(message: "Không thể cập nhật vị trí hiện tại");
        return false;
      }
    }
  }

  Future<Set<ProvinceModel>> getProvince() async {
    // get province from backend
    var endpoint = "/map/province";
    var response = await ApiHelper().get(endpoint);
    if (response.statusCode == HttpStatus.ok) {
      var jsonList = jsonDecode(response.body);
      List<ProvinceModel> list = jsonList
          .map((e) => ProvinceModel.fromJson(e))
          .toList()
          .cast<ProvinceModel>();
      // sort list
      list = list.toList()..sort((a, b) => a.province.compareTo(b.province));
      Set<ProvinceModel> sorted = list.toSet().cast<ProvinceModel>();
      return sorted;
    } else {
      ErrorHelper.showError(message: "Không thể lấy danh sách tỉnh thành");
      return {};
    }
  }

  Future<Set<DistrictModel>> getDistrict(String? provinceId) async {
    if (provinceId == null || provinceId.isEmpty) {
      return {};
    }
    // get district from backend
    var endpoint = "/map/district?province_id=$provinceId";
    var response = await ApiHelper().get(endpoint);
    if (response.statusCode == HttpStatus.ok) {
      var jsonList = jsonDecode(response.body);
      List<DistrictModel> list = jsonList
          .map((e) => DistrictModel.fromJson(e))
          .toList()
          .cast<DistrictModel>();
      // sort list
      list = list.toList()..sort((a, b) => a.fullName.compareTo(b.fullName));
      Set<DistrictModel> sorted = list.toSet().cast<DistrictModel>();
      return sorted;
    } else {
      ErrorHelper.showError(message: "Không thể lấy danh sách quận huyện");
      return {};
    }
  }
}
