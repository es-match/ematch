import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

final CalendarController _calendarController = CalendarController();

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Agenda"),
        ),
        body: buildCalendar(),
      ),
    );
  }

  TableCalendar buildCalendar() {
    return TableCalendar(
      availableCalendarFormats: {
        CalendarFormat.month: 'Mensal',
        CalendarFormat.twoWeeks: '2 Semanas',
        CalendarFormat.week: 'Semanal',
      },
      calendarController: _calendarController,
      locale: 'pt_BR',
    );
  }
}
