// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:sharing_cafe/helper/api_helper.dart';
import 'package:sharing_cafe/helper/error_helper.dart';
import 'package:sharing_cafe/model/account_model.dart';

class AccountService {
  Future<AccountModel> login(String userName, String password) async {
    try {
      var endpoint = "/user/login";
      var data = {"email": userName, "password": password};
      var response = await ApiHelper().post(endpoint, data);
      if (response.statusCode == HttpStatus.ok) {
        var json = jsonDecode(response.body);
        return AccountModel.fromJson(json);
      } else {
        throw Exception("Unauthorized: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      ErrorHelper.showError(message: "Không thể đăng nhập !");
      rethrow;
    }
  }
}
