// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:sharing_cafe/enums.dart';
import 'package:sharing_cafe/helper/error_helper.dart';
import 'package:sharing_cafe/helper/image_helper.dart';
import 'package:sharing_cafe/helper/shared_prefs_helper.dart';
import 'package:sharing_cafe/model/interest_model.dart';
import 'package:sharing_cafe/model/user_profile_model.dart';
import 'package:sharing_cafe/service/image_service.dart';
import 'package:sharing_cafe/service/interest_service.dart';
import 'package:sharing_cafe/service/user_profile_service.dart';

class UserProfileProvider extends ChangeNotifier {
  // private variables
  UserProfileModel? _userProfile;
  List<InterestModel> _listInterests = [];
  List<ImageFile> _galleryImage = [];
  //public
  UserProfileModel get userProfile => _userProfile!;
  List<InterestModel> get listInterests => _listInterests;
  List<ImageFile> get galleryImage => _galleryImage;

  Future<UserProfileModel?> getUserProfile() async {
    _userProfile = await UserProfileService().getUserProfile();
    notifyListeners();
    return _userProfile;
  }

  Future getListInterests() async {
    _listInterests = await InterestService().getListInterests();
    notifyListeners();
  }

  setUserAvt(String url) {
    userProfile.profileAvatar = url;
    notifyListeners();
  }

  Future updateUserGallery(List<ImageFile> images) async {
    var refId = await SharedPrefHelper.getUserId();
    var type = ImageType.user;
    _galleryImage = images;
    notifyListeners();
    return await ImageService().updateImageLinks(images, refId, type);
  }

  Future getUserGallery() async {
    var refId = await SharedPrefHelper.getUserId();
    var type = ImageType.user;
    var images = await ImageService().getImageLinks(refId: refId, type: type);
    _galleryImage = images
        .map((e) => ImageFile(
              e.url,
              path: e.url,
              name: e.url,
              extension: ImageHelper.getExtension(e.url),
            ))
        .toList();
    notifyListeners();
  }

  Future updateUserProfile({
    required String? profileAvatar,
    required String? userName,
    required String? age,
    required String? address,
    required String? gender,
    required String? story,
    required String? purpose,
    required String? favoriteLocation,
    required DateTime? dob,
    required String? provinceId,
    required String? districtId,
  }) async {
    try {
      if (profileAvatar == null || profileAvatar.isEmpty) {
        throw ArgumentError('Hình ảnh là bắt buộc và không được để trống.');
      }
      if (userName == null || userName.isEmpty) {
        throw ArgumentError('Tên là bắt buộc và không được để trống.');
      }
      // if (age == null || age.isEmpty) {
      //   throw ArgumentError('Tuổi là bắt buộc và không được để trống.');
      // }
      if (gender == null || gender.isEmpty) {
        throw ArgumentError('Giới tính là bắt buộc và không được để trống.');
      }
      if (dob == null) {
        throw ArgumentError('Ngày sinh là bắt buộc và không được để trống.');
      }

      return await UserProfileService().updateUserProfile(
        profileAvatar: profileAvatar,
        userName: userName,
        age: age ?? '',
        address: address,
        gender: gender,
        story: story,
        purpose: purpose,
        favoriteLocation: favoriteLocation,
        dob: dob.toIso8601String(),
        provinceId: provinceId,
        districtId: districtId,
      );
    } catch (e) {
      if (e is ArgumentError) {
        ErrorHelper.showError(message: e.message);
      } else {
        ErrorHelper.showError(message: e.toString());
      }
    }
  }

  Future updateInterest({
    List<String>? interestId,
  }) async {
    try {
      // Validate Interest ID
      if (interestId == null) {
        throw ArgumentError('Hãy chọn sở thích của bạn.');
      }

      return await UserProfileService().updateInterest(
        interestId: interestId,
      );
    } catch (e) {
      if (e is ArgumentError) {
        ErrorHelper.showError(message: e.message);
      } else {
        ErrorHelper.showError(message: e.toString());
      }
    }
  }

  Future updateProblem({
    List<String>? problem,
  }) async {
    try {
      if (problem == null) {
        throw ArgumentError('Hãy chọn.');
      }

      return await UserProfileService().updateProblem(
        problem: problem,
      );
    } catch (e) {
      if (e is ArgumentError) {
        ErrorHelper.showError(message: e.message);
      } else {
        ErrorHelper.showError(message: e.toString());
      }
    }
  }

  Future updateUnlikeTopic({
    List<String>? unlikeTopic,
  }) async {
    try {
      if (unlikeTopic == null) {
        throw ArgumentError('Hãy chọn.');
      }

      return await UserProfileService().updateUnlikeTopic(
        unlikeTopic: unlikeTopic,
      );
    } catch (e) {
      if (e is ArgumentError) {
        ErrorHelper.showError(message: e.message);
      } else {
        ErrorHelper.showError(message: e.toString());
      }
    }
  }

  Future updateFavoriteDrink({
    List<String>? favoriteDrink,
  }) async {
    try {
      if (favoriteDrink == null) {
        throw ArgumentError('Hãy chọn.');
      }

      return await UserProfileService().updateFavoriteDrink(
        favoriteDrink: favoriteDrink,
      );
    } catch (e) {
      if (e is ArgumentError) {
        ErrorHelper.showError(message: e.message);
      } else {
        ErrorHelper.showError(message: e.toString());
      }
    }
  }

  Future updateFreetime({
    List<String>? freeTime,
  }) async {
    try {
      if (freeTime == null) {
        throw ArgumentError('Hãy chọn.');
      }

      return await UserProfileService().updateFreetime(
        freeTime: freeTime,
      );
    } catch (e) {
      if (e is ArgumentError) {
        ErrorHelper.showError(message: e.message);
      } else {
        ErrorHelper.showError(message: e.toString());
      }
    }
  }
}
