// lib/bloc/calender_event/calendar_event_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task1_getx_no_one_academy/src/data/repositories/calendar_repository.dart';
import 'package:task1_getx_no_one_academy/src/model/calendar_event.dart';

class CalendarEventState {
  final List<CalendarEvent> events;
  final List<CalendarEvent> filteredEvents;

  CalendarEventState(this.events, this.filteredEvents);
}

class CalendarEventCubit extends Cubit<CalendarEventState> {
  final CalendarRepository _calendarRepository = CalendarRepository();

  CalendarEventCubit() : super(CalendarEventState([], []));

  void fetchEvents() async {
    // Request calendar permission
    var status = await _calendarRepository.getCalendarPermissionStatus();

    if (status.isGranted) {
      final List<CalendarEvent> events =
          await _calendarRepository.fetchEvents();
      emit(CalendarEventState(events, []));
    } else if (status.isDenied) {
      _showPermissionDeniedDialog();
    } else {
      // Handle other cases, if needed
    }
  }

  void _showPermissionDeniedDialog() {
    emit(CalendarEventState([], [])); // Reset events and filteredEvents
    // Show AlertDialog
    _calendarRepository.showPermissionDeniedDialog();
  }

  void selectDate(DateTime selectedDate) {
    // Filter events for the selected date
    final List<CalendarEvent> selectedDateEvents = state.events.where((event) {
      // You might need to adjust the comparison based on your event's structure
      return event.startTime!.year == selectedDate.year &&
          event.startTime!.month == selectedDate.month &&
          event.startTime!.day == selectedDate.day;
    }).toList();

    // Emit the state with both events and filteredEvents
    emit(CalendarEventState(state.events, selectedDateEvents));
  }
}
