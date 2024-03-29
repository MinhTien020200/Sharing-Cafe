// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharing_cafe/model/user_profile_model.dart';
import 'package:sharing_cafe/service/account_service.dart';

class AccountProvider extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // private variables
  UserProfileModel? _userProfile;
  //public
  UserProfileModel get userProfile => _userProfile!;

  Future login(String email, String password) async {
    var pref = await _prefs;
    var result = await AccountService().login(email, password);
    pref.setString("accessToken", result.token);
    pref.setString("userId", result.userId);
    pref.setString("email", result.email);
    pref.setString("userName", result.userName);
    Fluttertoast.showToast(msg: "Đăng nhập thành công!");
    print(
        "${result.token}: ${result.userId}: ${result.email}: ${result.userName}");
  }

  Future logout() async {
    var pref = await _prefs;
    await pref.remove("accessToken");
    await pref.remove("userId");
    await pref.remove("email");
    await pref.remove("userName");
    _userProfile = null;
    Fluttertoast.showToast(msg: "Đăng xuất thành công!");
    notifyListeners();
  }

  Future register(String userName, String email, String password) async {
    var pref = await _prefs;
    var result = await AccountService().register(userName, email, password);
    pref.setString("accessToken", result.token);
    pref.setString("userId", result.userId);
    pref.setString("email", result.email);
    pref.setString("userName", result.userName);
    pref.setString("password", result.password);
    Fluttertoast.showToast(msg: "Register successfully");
    print(
        "${result.token}: ${result.userId}: ${result.email}: ${result.userName}: ${result.password}");
  }

  Future getUserProfile(String id) async {
    _userProfile = await AccountService().getUserProfile(id);
    notifyListeners();
  }
}
