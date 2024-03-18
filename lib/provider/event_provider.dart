import 'package:flutter/material.dart';
import 'package:sharing_cafe/model/event_model.dart';
import 'package:sharing_cafe/service/event_service.dart';

class EventProvider extends ChangeNotifier {
  // private variables
  List<EventModel> _newEvents = [];
  List<EventModel> _suggestEvents = [];
  List<EventModel> _myEvents = [];
  EventModel? _eventDetails;

  // public
  List<EventModel> get newEvents => _newEvents;
  List<EventModel> get suggestEvents => _suggestEvents;
  List<EventModel> get myEvents => _myEvents;
  EventModel get eventDetails => _eventDetails!;

  Future getNewEvents() async {
    _newEvents = await EventService().getNewEvents();
    notifyListeners();
  }

  Future getSuggestEvents() async {
    _suggestEvents = await EventService().getSuggestEvents();
    notifyListeners();
  }

  Future getEventDetails(String id) async {
    _eventDetails = await EventService().getEventDetails(id);
    notifyListeners();
  }

  Future getMyEvents() async {
    _myEvents = await EventService().getMyEvents();
    notifyListeners();
  }
}
