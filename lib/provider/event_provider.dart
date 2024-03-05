import 'package:flutter/material.dart';
import 'package:sharing_cafe/model/event_model.dart';
import 'package:sharing_cafe/service/event_service.dart';

class EventProvider extends ChangeNotifier {
  // private variables
  List<EventModel> _newEvents = [];
  List<EventModel> _suggestEvents = [];

  // public
  List<EventModel> get newEvents => _newEvents;
  List<EventModel> get suggestEvents => _suggestEvents;

  Future getNewEvents() async {
    _newEvents = await EventService().getEvents();
    notifyListeners();
  }

  Future getSuggestEvents() async {
    _suggestEvents = await EventService().getEvents();
    notifyListeners();
  }
}
