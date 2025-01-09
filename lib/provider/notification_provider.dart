import 'package:flutter/material.dart';
import 'package:sharing_cafe/enums.dart';
import 'package:sharing_cafe/model/notification_model.dart';
import 'package:sharing_cafe/service/notification_service.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationModel> _notifications = [];
  List<NotificationModel> get notifications => _notifications;

  Future getNotifications() async {
    _notifications = await NotificationService().getNotifications();
    notifyListeners();
  }

  Future readNotification(String id) async {
    await NotificationService().markAsRead(id);
    _notifications = _notifications.map((e) {
      if (e.id == id) {
        e.status = NotificationStatus.read;
      }
      return e;
    }).toList();
    notifyListeners();
  }
}
