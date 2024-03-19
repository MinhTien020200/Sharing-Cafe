import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharing_cafe/helper/error_helper.dart';
import 'package:sharing_cafe/model/account_model.dart';
import 'package:sharing_cafe/service/account_service.dart';
import 'package:sharing_cafe/view/screens/sign_in/sign_in_screen.dart';

class AccountProvider extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setIsloading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future loginDemo(String userName, String password) async {
    var pref = await _prefs;
    var result = await AccountService().login(userName, password);
    pref.setString("accessToken", result.token);
    pref.setString("userId", result.userId);
    pref.setString("email", result.email);
    pref.setString("userName", result.userName);
    Fluttertoast.showToast(
        msg: "Login successfully. Token: ${result.token}"); // remove later
    print(result.token +
        ": " +
        result.userId +
        ": " +
        result.email +
        ": " +
        result.userName);
  }

  Future login(String userName, String password) async {
    setIsloading(true);
    notifyListeners();
    var pref = await _prefs;
    var result = await AccountService().login(userName, password);
    try {
      Response response = await post(
          Uri.parse(
              'https://sharing-coffee-be-capstone-com.onrender.com/api-docs/user/login'),
          body: {'email': userName, 'password': password});

      if (response.statusCode == 200 || response.statusCode == 201) {
        pref.setString("accessToken", result.token);
        pref.setString("userId", result.userId);
        pref.setString("email", result.email);
        pref.setString("userName", result.userName);
        Fluttertoast.showToast(
            msg: "Login successfully. Token: ${result.token}"); // remove later
        print(result.token +
            ": " +
            result.userId +
            ": " +
            result.email +
            ": " +
            result.userName);
      } else {
        ErrorHelper.showError(message: "Không thể đăng nhập !");
      }
    } catch (e) {
      setIsloading(false);
      print(e.toString());
    }
  }
}
