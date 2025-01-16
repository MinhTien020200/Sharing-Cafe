// ignore_for_file: avoid_print

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharing_cafe/constants.dart';
import 'package:sharing_cafe/provider/event_provider.dart';

class DayViewScreen extends StatefulWidget {
  static String routeName = "/day-view";
  const DayViewScreen({super.key});

  @override
  State<DayViewScreen> createState() => _DayViewScreenState();
}

DateTime get _now => DateTime.now();

class _DayViewScreenState extends State<DayViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(builder: (context, value, child) {
      final List<CalendarEventData> events = value.selectedCalendarCell;
      return Scaffold(
        appBar: AppBar(
          title: const Text("Lịch của tôi"),
        ),
        body: DayView(
          controller: EventController()..addAll(events),
          showVerticalLine: true, // To display live time line in day view.
          showLiveTimeLineInAllDays:
              true, // To display live time line in all pages in day view.
          minDay: DateTime(1990),
          maxDay: DateTime(2050),
          initialDay: events.firstOrNull?.date ?? _now,
          heightPerMinute: 1, // height occupied by 1 minute time span.
          eventArranger:
              const SideEventArranger(), // To define how simultaneous events will be arranged.
          onEventTap: (events, date) => print(events),
          onEventDoubleTap: (events, date) => print(events),
          onEventLongTap: (events, date) => print(events),
          onDateLongPress: (date) => print(date),
          headerStyle: const HeaderStyle(
              decoration: BoxDecoration(
            color: kPrimaryLightColor,
          )),
          eventTileBuilder:
              (date, events, boundary, startDuration, endDuration) => Container(
            decoration: BoxDecoration(
              color: kPrimaryLightColor,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: events.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(events[index].title),
                  subtitle: Text(events[index].description ?? ""),
                );
              },
            ),
          ),
        ),
      );
    });
  }
}
