// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:sharing_cafe/model/interest_model.dart';
import 'package:sharing_cafe/model/user_profile_model.dart';
import 'package:sharing_cafe/service/interest_service.dart';
import 'package:sharing_cafe/service/user_profile_service.dart';

class UserProfileProvider extends ChangeNotifier {
  // private variables
  UserProfileModel? _userProfile;
  List<InterestModel> _listInterests = [];
  //public
  UserProfileModel get userProfile => _userProfile!;
  List<InterestModel> get listInterests => _listInterests;

  Future getUserProfile() async {
    _userProfile = await UserProfileService().getUserProfile();
    notifyListeners();
  }

  Future getListInterests() async {
    _listInterests = await InterestService().getListInterests();
    notifyListeners();
  }
}
