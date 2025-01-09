import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharing_cafe/constants.dart';
import 'package:sharing_cafe/enums.dart';
import 'package:sharing_cafe/helper/datetime_helper.dart';
import 'package:sharing_cafe/provider/notification_provider.dart';

class NotificationScreen extends StatefulWidget {
  static String routeName = "notification";
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<NotificationProvider>(context, listen: false)
        .getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Thông báo",
          style: heading2Style,
        ),
      ),
      body: Consumer<NotificationProvider>(builder: (context, value, child) {
        var data = value.notifications;
        if (data.isEmpty) {
          return const Center(
            child: Text("Không có thông báo nào."),
          );
        }
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (data[index].status == NotificationStatus.unread) {
                  Provider.of<NotificationProvider>(context, listen: false)
                      .readNotification(data[index].id);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: data[index].status == NotificationStatus.read
                      ? Colors.white12
                      : kPrimaryLightColor,
                ),
                child: ListTile(
                  title: Text(
                    data[index].content,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle:
                      Text(DateTimeHelper.howOldFrom(data[index].createdAt)),
                  trailing: Text(data[index].status == NotificationStatus.read
                      ? "Đã đọc"
                      : "Chưa đọc"),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
