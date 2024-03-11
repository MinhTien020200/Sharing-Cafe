import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharing_cafe/service/account_service.dart';

class AccountProvider extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future login(String userName, String password) async {
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
}
