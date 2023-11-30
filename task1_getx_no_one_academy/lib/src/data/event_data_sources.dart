// lib/data/event_data_source.dart
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:task1_getx_no_one_academy/src/model/calendar_event.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<CalendarEvent> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return (appointments![index] as CalendarEvent).startTime!;
  }

  @override
  DateTime getEndTime(int index) {
    return (appointments![index] as CalendarEvent).endTime!;
  }

  @override
  String getSubject(int index) {
    return (appointments![index] as CalendarEvent).eventName ?? 'No events';
  }

  @override
  Color getColor(int index) {
    return Colors.blue;
  }

  @override
  bool isAllDay(int index) {
    return false;
  }
}
