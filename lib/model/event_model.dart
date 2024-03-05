import 'package:sharing_cafe/helper/datetime_helper.dart';

class EventModel {
  final String eventId;
  final String organizerId;
  final String title;
  final String description;
  final DateTime timeOfEvent;
  final String location;
  final int participantsCount;
  final bool isAprrove;
  final String backgroundImage;
  final DateTime createdAt;

  EventModel(
      {required this.eventId,
      required this.organizerId,
      required this.title,
      required this.description,
      required this.timeOfEvent,
      required this.location,
      required this.participantsCount,
      required this.isAprrove,
      required this.backgroundImage,
      required this.createdAt});

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      eventId: json['event_id'],
      organizerId: json['organizer_id'],
      title: json['title'],
      description: json['description'],
      timeOfEvent: DateTimeHelper.parseToLocal(json['time_of_event']),
      location: json['location'],
      participantsCount: json['participants_count'],
      isAprrove: json['is_approve'],
      backgroundImage: json['background_img'],
      createdAt: DateTimeHelper.parseToLocal(json['created_at']),
    );
  }
}
