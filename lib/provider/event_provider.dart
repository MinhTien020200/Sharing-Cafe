import 'package:flutter/material.dart';
import 'package:sharing_cafe/model/event_model.dart';
import 'package:sharing_cafe/service/event_service.dart';

class EventProvider extends ChangeNotifier {
  // private variables
  List<EventModel> _newEvents = [];
  List<EventModel> _suggestEvents = [];
  List<EventModel> _myEvents = [];
  EventModel? _eventDetails;
  final List<String> _searchHistory = [];
  List<EventModel> _searchEvents = [];
  // public
  List<EventModel> get newEvents => _newEvents;
  List<EventModel> get suggestEvents => _suggestEvents;
  List<EventModel> get myEvents => _myEvents;
  EventModel get eventDetails => _eventDetails!;
  List<String> get searchHistory => _searchHistory;
  List<EventModel> get searchEvents => _searchEvents;

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

  void removeFromSearchHistory(String query) {
    _searchHistory.remove(query);
    notifyListeners();
  }

  void removeAllSearchHistory() {
    _searchHistory.clear();
    notifyListeners();
  }

  Future search(String searchString) async {
    if (searchString == "") {
      _searchEvents.clear();
      notifyListeners();
      return;
    }
    _searchEvents = await EventService().getEvents(searchString);
    notifyListeners();
  }

  disposeSearchEvents() {
    _searchEvents.clear();
    notifyListeners();
  }

  void insertSearchHistry(String value) {
    if (value.isNotEmpty) {
      _searchHistory.add(value);
      notifyListeners();
    }
  }
}
