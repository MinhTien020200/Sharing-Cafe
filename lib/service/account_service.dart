// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:sharing_cafe/helper/api_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharing_cafe/helper/error_helper.dart';

class AccountService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> login(String email, String password) async {
    try {
      var endpoint = "/user/login";
      var data = {"email": email, "password": password};
      final response = await ApiHelper().post(endpoint, data);
      jsonEncode(<String, String>{
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        // Authentication successful
        var responseData = jsonDecode(response.body);
        var pref = await _prefs;
        pref.setString("accessToken", responseData['token']);
        pref.setString("userId", responseData['userId']);
        pref.setString("email", responseData['email']);
        pref.setString("userName", responseData['userName']);
        Fluttertoast.showToast(
            msg: "Login successfully. Token: ${responseData['token']}");
        return true;
      } else {
        // Authentication failed
        throw Exception("Unauthorized: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      ErrorHelper.showError(message: "Không thể đăng nhập !");
      rethrow;
    }
  }

  // Future<AccountModel> login(String email, String password) async {
  //   try {
  //     var endpoint = "/user/login";
  //     var data = {"email": email, "password": password};
  //     var response = await ApiHelper().post(endpoint, data);
  //     if (response.statusCode == HttpStatus.ok) {
  //       var json = jsonDecode(response.body);
  //       return AccountModel.fromJson(json);
  //     } else {
  //       throw Exception("Unauthorized: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     print(e);
  //     ErrorHelper.showError(message: "Không thể đăng nhập !");
  //     rethrow;
  //   }
  // }
}
