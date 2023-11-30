// lib/ui/pages/calendar_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:task1_getx_no_one_academy/src/bloc/calender_event/calendar_event_cubit.dart';
import 'package:task1_getx_no_one_academy/src/data/event_data_sources.dart';
import 'package:task1_getx_no_one_academy/src/model/calendar_event.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendar')),
      body: BlocBuilder<CalendarEventCubit, CalendarEventState>(
        builder: (context, state) {
          return Column(
            children: [
              Flexible(
                child: SfCalendar(
                  view: CalendarView.month,
                  dataSource: EventDataSource(state.events),
                  onTap: (CalendarTapDetails details) {
                    context
                        .read<CalendarEventCubit>()
                        .selectDate(details.date!);
                  },
                ),
              ),
              Expanded(
                child: EventListView(events: state.filteredEvents),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CalendarEventCubit>().fetchEvents();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class EventListView extends StatelessWidget {
  final List<CalendarEvent> events;

  const EventListView({Key? key, required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(events[index].eventName ?? 'No events'),
          subtitle: Text(
            '${events[index].startTime?.toLocal()} - ${events[index].endTime?.toLocal()}',
          ),
        );
      },
    );
  }
}
