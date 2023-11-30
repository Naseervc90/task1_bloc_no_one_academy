import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1_getx_no_one_academy/src/bloc/calender_event/calendar_event_cubit.dart';
import 'package:task1_getx_no_one_academy/src/data/repositories/calendar_repository.dart';
import 'package:task1_getx_no_one_academy/src/ui/pages/calendar_page.dart';

class NavigatorKey {
  static final navKey = GlobalKey<NavigatorState>();
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalendarEventCubit(),
      child: MaterialApp(
        navigatorKey: NavigatorKey.navKey,
        title: 'Your App Title',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CalendarPage(),
      ),
    );
  }
}
