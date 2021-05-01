import 'package:ematch/App/controller/locationController.dart';
import 'package:ematch/App/custom_widgets/ownerLocationEventtableCalendar.dart';
import 'package:ematch/App/model/locationModel.dart';
import 'package:ematch/App/view/OwnerViews/locationPage/editLocationPage.dart';
import 'package:flutter/material.dart';
import 'editLocationAvaiability.dart';

class LocationCalendarPage extends StatefulWidget {
  final LocationModel location;

  LocationCalendarPage({Key key, this.location}) : super(key: key);
  @override
  _LocationCalendarPageState createState() => _LocationCalendarPageState();
}

class _LocationCalendarPageState extends State<LocationCalendarPage> {
  Future<Map<DateTime, List>> futureEvents;

  @override
  void initState() {
    super.initState();
    LocationController locationController = LocationController();
    futureEvents = locationController.getLocationEvents(widget.location.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.location.locationName),
            Row(
              children: [
                Icon(Icons.calendar_today),
                Text("  Calendário"),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: OwnerLocationEventtableCalendar(
          location: this.widget.location,
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 12,
            width: MediaQuery.of(context).size.width / 2,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) =>
                //             EditLocationPage(locationModel: widget.model)));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.map_outlined),
                  Text(
                    "Detalhes",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 12,
            width: MediaQuery.of(context).size.width / 2,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditLocationAvaiability(widget.location)));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.lock_clock),
                  Text(
                    "Horários",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
