import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharing_cafe/service/account_service.dart';

class AccountProvider extends ChangeNotifier {
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future login(String email, String password) async {
    var success = await AccountService().login(email, password);
    if (success) {
      _isLoggedIn = true;
    } else {
      _isLoggedIn = false;
    }
    notifyListeners();

    // var pref = await _prefs;
    // var result = await AccountService().login(email, password);
    // pref.setString("accessToken", result.token);
    // pref.setString("userId", result.userId);
    // pref.setString("email", result.email);
    // pref.setString("userName", result.userName);
    // Fluttertoast.showToast(
    //     msg: "Login successfully. Token: ${result.token}"); // remove later
    // // print(result.token +
    //     ": " +
    //     result.userId +
    //     ": " +
    //     result.email +
    //     ": " +
    //     result.userName);
  }
}
