// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:sharing_cafe/helper/api_helper.dart';
import 'package:sharing_cafe/helper/error_helper.dart';
import 'package:sharing_cafe/model/notification_model.dart';

class NotificationService {
  //get nofications
  Future<List<NotificationModel>> getNotifications() async {
    try {
      var response = await ApiHelper().get('/auth/notification/get-history');
      if (response.statusCode == HttpStatus.ok) {
        var data = json.decode(response.body);
        List<NotificationModel> notifications = [];
        for (var item in data) {
          notifications.add(NotificationModel.fromJson(item));
        }
        notifications.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        return notifications;
      } else {
        ErrorHelper.showError(
            message: "Lỗi ${response.statusCode}: Không thể lấy thông báo");
      }
    } on Exception catch (_, e) {
      print(e);
    }
    return [];
  }

  //mark notification as read
  Future<bool> markAsRead(String notificationId) async {
    try {
      var response = await ApiHelper().put('/notifications/readNotifications', {
        "notification_ids": [notificationId]
      });
      if (response.statusCode == HttpStatus.ok) {
        return true;
      } else {
        ErrorHelper.showError(
            message: "Lỗi ${response.statusCode}: Không thể đánh dấu đã đọc");
      }
    } on Exception catch (_, e) {
      print(e);
    }
    return false;
  }
}
