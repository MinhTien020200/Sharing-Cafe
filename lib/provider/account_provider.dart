// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharing_cafe/service/account_service.dart';
import 'package:sharing_cafe/service/location_service.dart';

class AccountProvider extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future login(String email, String password) async {
    var pref = await _prefs;
    var token = await getToken();
    if (token == null) {
      Fluttertoast.showToast(msg: "Token is null");
    }
    var result = await AccountService().login(email, password, token);
    pref.setString("accessToken", result.token);
    pref.setString("userId", result.userId);
    pref.setString("email", result.email);
    pref.setString("userName", result.userName);
    Fluttertoast.showToast(msg: "Login successfully");
    print(
        "${result.token}: ${result.userId}: ${result.email}: ${result.userName}");
  }

  Future logout() async {
    var pref = await _prefs;
    await pref.remove("accessToken");
    await pref.remove("userId");
    await pref.remove("email");
    await pref.remove("userName");
    Fluttertoast.showToast(msg: "Đăng xuất thành công!");
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
    await LocationService().updateLocation();
  }

  Future<String?> getToken() async {
    var token = await FirebaseMessaging.instance.getToken();
    if (kDebugMode) {
      print(token);
      if (token != null) {
        var pref = await _prefs;
        pref.setString('notiToken', token);
      }
    }
    return token;
  }
}
