import 'package:ematch/App/custom_widgets/locationEventtableCalendar.dart';
import 'package:flutter/material.dart';

class LocationCalendarPage extends StatefulWidget {
  final Future<Map<DateTime, List>> futureEvents;

  const LocationCalendarPage({Key key, this.futureEvents}) : super(key: key);
  @override
  _LocationCalendarPageState createState() => _LocationCalendarPageState();
}

class _LocationCalendarPageState extends State<LocationCalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendário"),
      ),
      body: LocationEventtableCalendar(
        futureEvents: widget.futureEvents,
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => EditLocationAvaiability(
          //                 widget.locationModel)));
          //   },
          //   child: Text("Horários"),
          // ),
          Container(
            height: MediaQuery.of(context).size.height / 12,
            width: MediaQuery.of(context).size.width / 2,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  // isEditMode = true;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.edit),
                  Text("Editar Dados"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
