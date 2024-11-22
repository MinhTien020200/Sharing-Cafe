class CalendarModel {
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String type;

  CalendarModel({
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.type,
  });

  factory CalendarModel.fromJson(Map<String, dynamic> json) {
    return CalendarModel(
      title: json['title'],
      description: json['description'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      type: json['type'],
    );
  }
}
