//  Copyright (c) 2019 Aleksander Woźniak
//  Licensed under Apache License v2.0

import 'dart:ui';

import 'package:ematch/App/controller/locationController.dart';
import 'package:ematch/App/model/eventModel.dart';
import 'package:ematch/App/model/locationModel.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

// Example holidays
final Map<DateTime, List> _holidays = {
  // DateTime(2021, 5, 5): ['New Year\'s Day'],
  // DateTime(2021, 1, 6): ['Epiphany'],
  // DateTime(2021, 2, 14): ['Valentine\'s Day'],
  // DateTime(2021, 4, 21): ['Easter Sunday'],
  // DateTime(2021, 4, 22): ['Easter Monday'],
};

class OwnerLocationEventtableCalendar extends StatefulWidget {
  final LocationModel location;

  OwnerLocationEventtableCalendar({Key key, this.location}) : super(key: key);

  @override
  _OwnerLocationEventtableCalendarState createState() =>
      _OwnerLocationEventtableCalendarState();
}

class _OwnerLocationEventtableCalendarState
    extends State<OwnerLocationEventtableCalendar>
    with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  DateTime today = DateTime.now();
  Map<String, DateTime> weekdaysEnabled;
  Future<Map<DateTime, List>> futureEvents;
  String title;
  LocationController locationController = LocationController();

  @override
  void initState() {
    super.initState();
    futureEvents = locationController.getLocationEvents(widget.location.id);
    today = DateTime.now();
    if (_selectedEvents == null) _selectedEvents = [];
    // _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    // print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    // print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    // print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureEvents,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          _events = snapshot.data;
          if (_selectedEvents.isEmpty ?? true)
            _selectedEvents = _events[DateTime.now()] ?? [];

          return buildBody();
        } else
          return Center(child: CircularProgressIndicator());
      },
    );
  }

  Container buildBody() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          // Switch out 2 lines below to play with TableCalendar's settings
          //-----------------------
          _buildTableCalendar(),
          // _buildTableCalendarWithBuilders(),
          const SizedBox(height: 8.0),
          _buildButtons(),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Agendamentos:",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
              flex: 6,
              child:
                  // widget.customEventList ??
                  _buildEventList()),
        ],
      ),
    );
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.deepOrangeAccent,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TableCalendar(
        availableCalendarFormats: {
          CalendarFormat.month: 'Mensal',
          // CalendarFormat.twoWeeks: '2 Semanas',
          // CalendarFormat.week: 'Semanal',
        },
        calendarController: _calendarController,
        locale: 'pt_BR',
        events: _events,
        holidays: _holidays,
        weekendDays: widget.location.getLocationDaysDisable().values.toList(),
        // enabledDayPredicate: (date) {
        //   return date.weekday != DateTime.sunday;
        // },
        startingDayOfWeek: StartingDayOfWeek.monday,
        calendarStyle: CalendarStyle(
          contentPadding: const EdgeInsets.all(0.0),
          selectedColor: Colors.deepOrange[700],
          todayColor: Colors.grey[700],
          markersColor: Colors.deepOrange[900],
          weekendStyle: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.w300,
            fontSize: 17,
          ),
          weekdayStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
          outsideDaysVisible: false,
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w300,
              fontSize: 17,
              height: 2),
          weekdayStyle: TextStyle(
            fontSize: 17,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            height: 2,
          ),
          dowTextBuilder: (date, locale) {
            return DateFormat.E(locale).format(date).toUpperCase();
          },
          decoration: BoxDecoration(
            color: Colors.deepOrangeAccent,
          ),
        ),

        headerStyle: HeaderStyle(
          decoration: BoxDecoration(
            color: Colors.deepOrangeAccent,
          ),
          centerHeaderTitle: true,
          titleTextBuilder: (date, locale) {
            return DateFormat.yMMMM(locale).format(date).toUpperCase();
          },
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          formatButtonTextStyle: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 18.0,
          ),
          formatButtonDecoration: BoxDecoration(
            color: Colors.deepOrange[400],
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        onDaySelected: _onDaySelected,
        onVisibleDaysChanged: _onVisibleDaysChanged,
        onCalendarCreated: _onCalendarCreated,
      ),
    );
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      locale: 'pl_PL',
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.deepOrange[300],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.amber[400],
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }

          return children;
        },
      ),
      onDaySelected: (date, events, holidays) {
        _onDaySelected(date, events, holidays);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
                ? Colors.brown[300]
                : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildButtons() {
    final dateTime = _events.keys.elementAt(_events.length - 2);

    return Column(
      children: <Widget>[
        // Row(
        //   mainAxisSize: MainAxisSize.max,
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: <Widget>[
        //     Container(
        //       height: MediaQuery.of(context).size.height / 14,
        //       width: MediaQuery.of(context).size.width / 3.2,
        //       child: ElevatedButton(
        //         child: Text('Mensal'),
        //         onPressed: () {
        //           setState(() {
        //             _calendarController.setCalendarFormat(CalendarFormat.month);
        //           });
        //         },
        //       ),
        //     ),
        //     Container(
        //       height: MediaQuery.of(context).size.height / 14,
        //       width: MediaQuery.of(context).size.width / 3.2,
        //       child: ElevatedButton(
        //         child: Text('2 Semanas'),
        //         onPressed: () {
        //           setState(() {
        //             _calendarController
        //                 .setCalendarFormat(CalendarFormat.twoWeeks);
        //           });
        //         },
        //       ),
        //     ),
        //     Container(
        //       height: MediaQuery.of(context).size.height / 14,
        //       width: MediaQuery.of(context).size.width / 3.2,
        //       child: ElevatedButton(
        //         child: Text('Semanal'),
        //         onPressed: () {
        //           setState(() {
        //             _calendarController.setCalendarFormat(CalendarFormat.week);
        //           });
        //         },
        //       ),
        //     ),
        //   ],
        // ),
        // Container(
        //   height: MediaQuery.of(context).size.height / 15,
        //   width: MediaQuery.of(context).size.width / 2,
        //   child: ElevatedButton(
        //     child: Text(
        //       'Mostrar Hoje\n(${today.day}/${today.month}/${today.year})',
        //       textAlign: TextAlign.center,
        //       style: TextStyle(
        //         fontSize: 18,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //     onPressed: () {
        //       _calendarController.setSelectedDay(
        //         DateTime(today.year, today.month, today.day),
        //         runCallback: true,
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents.map((event) {
        EventModel ev = event;
        var startTime =
            DateFormat("HH:mm").format(DateTime.parse(ev.startDate));
        var endTime = DateFormat("HH:mm")
            .format(DateTime.parse(ev.startDate).add(Duration(hours: 1)));
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[800],
            border: Border.all(width: 0.1),
            borderRadius: BorderRadius.circular(12.0),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: ListTile(
            title: Row(
              children: [
                Icon(Icons.timer),
                Text(
                  "($startTime - $endTime)\t",
                  style: TextStyle(
                    color: Colors.amber,
                  ),
                ),
                Text("${ev.userName}"),
              ],
            ),
            onTap: () => print('$event tapped!'),
          ),
        );
      }).toList(),
    );
  }
}
