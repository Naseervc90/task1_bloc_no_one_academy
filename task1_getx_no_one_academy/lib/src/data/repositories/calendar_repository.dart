// lib/data/calendar_repository.dart

import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task1_getx_no_one_academy/main.dart';
import 'package:task1_getx_no_one_academy/src/model/calendar_event.dart';

class CalendarRepository {
  final DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();

  Future<PermissionStatus> getCalendarPermissionStatus() async {
    return await Permission.calendarReadOnly.status;
  }

  void showPermissionDeniedDialog() {
    // Show AlertDialog
    showDialog(
      context: NavigatorKey.navKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Calendar Permission Denied'),
          content: Text(
            'This app needs calendar permission to fetch events. Please enable calendar permissions in the app settings.',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<List<CalendarEvent>> fetchEvents() async {
    final calendarsResult = await _deviceCalendarPlugin.retrieveCalendars();
    final List<CalendarEvent> events = [];

    for (final calendar in calendarsResult.data!) {
      final eventsResult = await _deviceCalendarPlugin.retrieveEvents(
        calendar.id,
        RetrieveEventsParams(
          startDate: DateTime.now(),
          endDate: DateTime.now().add(Duration(days: 30)),
        ),
      );

      events.addAll(eventsResult.data!.map((e) => CalendarEvent(
            eventName: e.title,
            startTime: e.start,
            endTime: e.end,
          )));
    }
    //log(events.first.appointments.toString());
    return events;
  }
}
