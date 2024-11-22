import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

class DayViewScreen extends StatefulWidget {
  static String routeName = "/day-view";
  const DayViewScreen({super.key});

  @override
  State<DayViewScreen> createState() => _DayViewScreenState();
}

DateTime get _now => DateTime.now();

class _DayViewScreenState extends State<DayViewScreen> {
  List<CalendarEventData> _events = [
    CalendarEventData(
      date: _now,
      title: "Project meeting",
      description: "Today is project meeting.",
      startTime: DateTime(_now.year, _now.month, _now.day, 18, 30),
      endTime: DateTime(_now.year, _now.month, _now.day, 22),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar"),
      ),
      body: DayView(
        controller: EventController()..addAll(_events),
        showVerticalLine: true, // To display live time line in day view.
        showLiveTimeLineInAllDays:
            true, // To display live time line in all pages in day view.
        minDay: DateTime(1990),
        maxDay: DateTime(2050),
        initialDay: _events.firstOrNull?.date ?? _now,
        heightPerMinute: 1, // height occupied by 1 minute time span.
        eventArranger:
            SideEventArranger(), // To define how simultaneous events will be arranged.
        onEventTap: (events, date) => print(events),
        onEventDoubleTap: (events, date) => print(events),
        onEventLongTap: (events, date) => print(events),
        onDateLongPress: (date) => print(date),
      ),
    );
  }
}
