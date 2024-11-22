import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:provider/provider.dart';
import 'package:sharing_cafe/provider/event_provider.dart';
import 'package:sharing_cafe/view/screens/calendar/day_view_screen.dart';

DateTime get _now => DateTime.now();

class MyCalendarScreen extends StatefulWidget {
  static String routeName = "/my-calendar";

  const MyCalendarScreen({super.key});

  @override
  State<MyCalendarScreen> createState() => _MyCalendarScreenState();
}

class _MyCalendarScreenState extends State<MyCalendarScreen> {
  @override
  void initState() {
    Provider.of<EventProvider>(context, listen: false).getCalendar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(builder: (context, value, child) {
      List<CalendarEventData> calendar = value.calendar.map((e) {
        return CalendarEventData(
          date: e.startDate,
          title: e.title,
          description: e.description,
          startTime: e.startDate,
          endTime: e.endDate,
        );
      }).toList();
      return Scaffold(
        appBar: AppBar(
          title: const Text("Lịch của tôi"),
        ),
        body: MonthView(
          controller: EventController()..addAll(calendar),
          // to provide custom UI for month cells.
          pagePhysics: const BouncingScrollPhysics(),
          minMonth: DateTime(1990),
          maxMonth: DateTime(2050),
          initialMonth: _now,
          cellAspectRatio: 1,
          onPageChange: (date, pageIndex) => print("$date, $pageIndex"),
          onCellTap: (events, date) {
            // Implement callback when user taps on a cell.
            Provider.of<EventProvider>(context, listen: false)
                .setSelectedCalendarCell(events);
            Navigator.pushNamed(context, DayViewScreen.routeName);
          },
          startDay: WeekDays.sunday, // To change the first day of the week.
          // This callback will only work if cellBuilder is null.
          onEventTap: (event, date) => print(event),
          onEventDoubleTap: (events, date) => print(events),
          onEventLongTap: (event, date) => print(event),
          onDateLongPress: (date) => print(date),
          showWeekTileBorder: false, // To show or hide header border
          hideDaysNotInMonth:
              true, // To hide days or cell that are not in current month
        ),
      );
    });
  }
}
