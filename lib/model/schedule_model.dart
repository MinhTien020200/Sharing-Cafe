class ScheduleModel {
  ScheduleModel({
    required this.createdAt,
    required this.scheduleId,
    required this.content,
    required this.location,
    required this.date,
    required this.senderId,
    required this.receiverId,
    required this.isAccept,
  });

  final DateTime createdAt;
  final String scheduleId;
  final String content;
  final String location;
  final DateTime date;
  final String senderId;
  final String receiverId;
  final bool? isAccept;

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        createdAt: DateTime.parse(json["created_at"]),
        scheduleId: json["schedule_id"],
        content: json["content"],
        location: json["location"],
        date: DateTime.parse(json["schedule_time"]),
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        isAccept: json["is_accept"],
      );

  Map<String, dynamic> toJson() => {
        "sender_id": senderId,
        "receiver_id": receiverId,
        "content": content,
        "location": location,
        "date": date.toIso8601String(),
      };
}
