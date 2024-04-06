// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:sharing_cafe/model/user_profile_model.dart';
import 'package:sharing_cafe/service/user_profile_service.dart';

class UserProfileProvider extends ChangeNotifier {
  // private variables
  UserProfileModel? _userProfile;
  //public
  UserProfileModel get userProfile => _userProfile!;

  Future getUserProfile() async {
    _userProfile = await UserProfileService().getUserProfile();
    notifyListeners();
  }
}
