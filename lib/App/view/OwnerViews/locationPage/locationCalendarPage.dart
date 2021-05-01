import 'package:ematch/App/controller/locationController.dart';
import 'package:ematch/App/custom_widgets/ownerLocationEventtableCalendar.dart';
import 'package:ematch/App/model/locationModel.dart';
import 'package:ematch/App/view/OwnerViews/locationPage/editLocationPage.dart';
import 'package:flutter/material.dart';
import 'editLocationAvaiability.dart';

class LocationCalendarPage extends StatefulWidget {
  final LocationModel model;

  LocationCalendarPage({Key key, this.model}) : super(key: key);
  @override
  _LocationCalendarPageState createState() => _LocationCalendarPageState();
}

class _LocationCalendarPageState extends State<LocationCalendarPage> {
  Future<Map<DateTime, List>> futureEvents;

  @override
  void initState() {
    super.initState();
    LocationController locationController = LocationController();
    futureEvents = locationController.getLocationEvents(widget.model.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.model.locationName),
            Row(
              children: [
                Icon(Icons.calendar_today),
                Text("  Calendário"),
              ],
            ),
          ],
        ),
      ),
      body: OwnerLocationEventtableCalendar(
        futureEvents: this.futureEvents,
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 12,
            width: MediaQuery.of(context).size.width / 2,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditLocationPage(locationModel: widget.model)));
              },
              child: Text("Detalhes"),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 12,
            width: MediaQuery.of(context).size.width / 2,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Horários"),
            ),
          ),
        ],
      ),
    );
  }
}
