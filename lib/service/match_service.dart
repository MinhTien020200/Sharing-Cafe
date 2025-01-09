import 'dart:convert';
import 'dart:io';

import 'package:sharing_cafe/enums.dart';
import 'package:sharing_cafe/helper/api_helper.dart';
import 'package:sharing_cafe/helper/error_helper.dart';
import 'package:sharing_cafe/helper/shared_prefs_helper.dart';
import 'package:sharing_cafe/model/filter_model.dart';
import 'package:sharing_cafe/model/gender_model.dart';
import 'package:sharing_cafe/model/matched_model.dart';
import 'package:sharing_cafe/model/profile_info_model.dart';
import 'package:sharing_cafe/model/profile_model.dart';

class MatchService {
  Future<List<ProfileModel>> getListProfiles(int limit, int offset,
      String? filterByAge, String? filterByGender) async {
    try {
      var endpoint = "/auth/matches-interest?limit=$limit&offset=$offset";
      if (filterByAge != null) {
        endpoint += "&filterByAge=$filterByAge";
      }
      if (filterByGender != null) {
        endpoint += "&filterByGender=$filterByGender";
      }
      var response = await ApiHelper().get(endpoint);
      if (response.statusCode == HttpStatus.ok) {
        var result = json.decode(response.body);
        var jsonList = result["data"] as List;
        return jsonList
            .map<ProfileModel>((e) => ProfileModel.fromJson(e))
            .toList();
      }
    } catch (e) {
      ErrorHelper.showError(message: "Không thể lấy danh sách người dùng");
    }
    return List.empty();
  }

  // /api/auth/user/auth/user-filter-setting
  Future<List<ProfileModel>> getUserFilterSetting() async {
    var endpoint = "/auth/user/auth/user-filter-setting";
    var response = await ApiHelper().get(endpoint);
    if (response.statusCode == HttpStatus.ok) {
      var result = json.decode(response.body);
      var jsonList = result as List;
      return jsonList
          .map<ProfileModel>((e) => ProfileModel.fromJson(e))
          .toList();
    }
    throw Exception("Lỗi ${response.statusCode}");
  }

  Future<bool> updateMatchStatus(String userId, MatchStatus status) async {
    var endpoint = "/auth/matching-status";
    bool isLike = status == MatchStatus.pending;
    var payload = {
      "user_id": userId,
      "status": isLike,
    };
    var response = await ApiHelper().put(endpoint, payload);
    if (response.statusCode == HttpStatus.ok) {
      json.decode(response.body);
      return true;
    } else {
      throw Exception("Action error: ${response.statusCode}");
    }
  }

  Future<List<MatchedModel>> getListFriends({bool pending = false}) async {
    var endpoint = "/auth/matched?status=${pending ? "Pending" : "Matched"}";
    var response = await ApiHelper().get(endpoint);
    if (response.statusCode == HttpStatus.ok) {
      var result = json.decode(response.body);
      var jsonList = result as List;
      return jsonList
          .map<MatchedModel>((e) => MatchedModel.fromJson(e))
          .toList();
    }
    return List.empty();
  }

  Future<ProfileInfoModel> getProfileInfo(String userId) async {
    var currentUserId = await SharedPrefHelper.getUserId();
    var endpoint = "/user/profile/$userId?currentUserId=$currentUserId";
    var response = await ApiHelper().get(endpoint);
    if (response.statusCode == HttpStatus.ok) {
      var result = json.decode(response.body);
      return ProfileInfoModel.fromJson(result);
    }
    throw Exception("Get profile info error: ${response.statusCode}");
  }

  // /api/auth/user/block/block-user
  Future<bool> blockUser(String userId) async {
    var endpoint = "/auth/user/block/block-user";
    var payload = {
      "blocked_id": userId,
    };
    var response = await ApiHelper().post(endpoint, payload);
    if (response.statusCode == HttpStatus.ok) {
      return true;
    }
    throw Exception("Lỗi ${response.statusCode}");
  }

  // /auth/user/auth/setting-filter
  Future<bool> updateFilterSetting(FilterModel filter) async {
    var endpoint = "/auth/user/auth/setting-filter";
    var payload = filter.toJson();
    var response = await ApiHelper().put(endpoint, payload);
    if (response.statusCode == HttpStatus.ok) {
      return true;
    }
    throw Exception("Lỗi ${response.statusCode}");
  }

  // /auth/user/auth/setting-filter
  Future<FilterModel> getFilterSetting() async {
    var endpoint = "/auth/user/auth/setting-filter";
    var response = await ApiHelper().get(endpoint);
    if (response.statusCode == HttpStatus.ok) {
      var result = json.decode(response.body);
      return FilterModel.fromJson(result);
    }
    throw Exception("Lỗi ${response.statusCode}");
  }

  // /user/gender
  Future<List<GenderModel>> getListGender() {
    var endpoint = "/user/gender";
    return ApiHelper().get(endpoint).then((response) {
      if (response.statusCode == HttpStatus.ok) {
        var result = json.decode(response.body);
        var jsonList = result as List;
        return jsonList
            .map<GenderModel>((e) => GenderModel.fromJson(e))
            .toList();
      }
      throw Exception("Lỗi ${response.statusCode}");
    });
  }

  Future unFriendWithMatchId(String matchedId) {
    var endpoint = "/auth/match/unfriend";
    return ApiHelper()
        .delete("$endpoint?matchedId=$matchedId")
        .then((response) {
      if (response.statusCode == HttpStatus.ok) {
        return true;
      }
      throw Exception("Lỗi ${response.statusCode}");
    });
  }
}
