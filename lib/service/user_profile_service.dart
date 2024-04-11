// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:sharing_cafe/helper/api_helper.dart';
import 'package:sharing_cafe/helper/error_helper.dart';
import 'package:sharing_cafe/model/user_profile_model.dart';

class UserProfileService {
  Future<UserProfileModel?> getUserProfile() async {
    try {
      var response = await ApiHelper().get('/auth/user/profile/');
      if (response.statusCode == HttpStatus.ok) {
        return UserProfileModel.fromJson(json.decode(response.body));
      } else {
        ErrorHelper.showError(
            message: "Lỗi ${response.statusCode}: Không thể lấy thông tin");
      }
    } on Exception catch (_, e) {
      print(e);
    }
    return null;
  }

  Future<bool> updateUserProfile({
    required List<String> interestId,
  }) async {
    try {
      var endpoint = "/auth/user/update-interests";
      var data = interestId.map((e) => {"interest_id": e}).toList();
      var response = await ApiHelper().putList(endpoint, data);
      if (response.statusCode == HttpStatus.ok) {
        return true;
      }
      ErrorHelper.showError(
          message: "Lỗi ${response.statusCode}: Không thể cập nhật thông tin");
    } catch (e) {
      print(e);
    }
    return false;
  }
}
