// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:sharing_cafe/helper/api_helper.dart';
import 'package:sharing_cafe/helper/error_helper.dart';
import 'package:sharing_cafe/model/event_model.dart';

class EventService {
  Future<List<EventModel>> getEvents() async {
    try {
      var response = await ApiHelper().get('event');
      if (response.statusCode == HttpStatus.ok) {
        var jsonList = json.decode(response.body) as List;
        return jsonList.map<EventModel>((e) => EventModel.fromJson(e)).toList();
      } else {
        ErrorHelper.showError(
            message:
                "Lỗi ${response.statusCode}: Không thể lấy danh sách sự kiện");
      }
    } on Exception catch (_, e) {
      print(e);
    }
    return [];
  }

  Future<EventModel?> getEventDetails(String eventId) async {
    try {
      var response = await ApiHelper().get('event/$eventId');
      if (response.statusCode == HttpStatus.ok) {
        return EventModel.fromJson(json.decode(response.body));
      } else {
        ErrorHelper.showError(
            message: "Lỗi ${response.statusCode}: Không thể lấy sự kiện");
      }
    } on Exception catch (_, e) {
      print(e);
    }
    return null;
  }
}
