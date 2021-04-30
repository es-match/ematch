import 'package:ematch/App/controller/locationController.dart';
import 'package:ematch/App/custom_widgets/userLocationEventtableCalendar.dart';
import 'package:ematch/App/model/locationModel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectEventDate extends StatefulWidget {
  SelectEventDate({this.location});

  @override
  _SelectEventDateState createState() => _SelectEventDateState();
  final LocationModel location;
}

class _SelectEventDateState extends State<SelectEventDate> {
  LatLng geoPosition;
  LocationController locationController = LocationController();
  GoogleMapController googleMapController;
  CalendarController _calendarController = CalendarController();
  Set<Marker> markers = Set();

  String startDropdownvalue;
  String endDropdownvalue;
  // String dropdownValue = 'One';
  @override
  void initState() {
    super.initState();
    setState(() {
      geoPosition = LatLng(widget.location.geolocation.dLatitude,
          widget.location.geolocation.dLongitude);
      setMarkers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Defina o horário"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildMap(context),
            Divider(),
            buildLocationValues(),
            Divider(),
            buildCalendarTable(context),
            Divider(),
            Container(
                child: Row(
              children: [
                DropdownButton(
                  value: startDropdownvalue,
                  onChanged: (String newValue) {
                    setState(() {
                      startDropdownvalue = newValue;
                      // if (int.parse(endDropdownvalue) <
                      //     int.parse(startDropdownvalue))
                      endDropdownvalue = startDropdownvalue;
                    });
                  },
                  items: dropDownMenuItems(),
                  style: const TextStyle(
                      color: Colors.white, backgroundColor: Colors.black),
                ),
                DropdownButton(
                  value: endDropdownvalue,
                  onChanged: (String newValue) {
                    setState(() {
                      endDropdownvalue = startDropdownvalue;
                    });
                  },
                  items: dropDownMenuItems(true)
                       .where((element) =>
                           int.parse(startDropdownvalue ?? "0")  <=
                           int.parse(element.value))
                       .toList(),
                      
                  style: const TextStyle(
                      color: Colors.white, backgroundColor: Colors.black),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> dropDownMenuItems([bool end = false]) {
    var hours = widget.location.avaiableHours.split(',').toList();

    // if (end) {
    //   hours = hours
    //       .where(
    //           (element) => int.parse(startDropdownvalue) <= int.parse(element))
    //       .toList();

    //   // bool foundGap = false;
    //   var lastIndex = -1;
    //   for (String el in hours) {
    //     try {
    //       var index = hours.indexOf(el);
    //       var nextEl = hours[index + 1];
    //       if (int.parse(nextEl) - int.parse(el) > 1) {
    //         lastIndex = index;
    //         break;
    //       }

    //       if (lastIndex != -1) {
    //         hours =
    //             hours.where((element) => lastIndex >= hours.indexOf(element));
    //       }
    //     } catch (e) {}
    //   }
    // }

    return hours.map<DropdownMenuItem<String>>((String value) {
      // String sufix = end ? "59" : "00";
      return DropdownMenuItem<String>(
        value: value,
        child: Text("1"),
      );
    }).toList();
  }

  Container buildCalendarTable(BuildContext context) {
    return Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: UserLocationEventtableCalendar(
        futureEvents: locationController.getLocationEvents(widget.location.id),
      ),
    ) //TableCalendarexample(), //buildCalendar(),
        );
  }

  Container buildMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        onCameraMove: (position) => {},
        mapToolbarEnabled: false,
        // zoomControlsEnabled: false,
        zoomGesturesEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(target: geoPosition, zoom: 14),
        markers: markers,
        onMapCreated: (controller) {
          googleMapController = controller;
        },
      ),
    );
  }

  Container buildLocationValues() {
    return Container(
      child: Text("Valor Por hora: ${widget.location.hourValue}"),
    );
  }

  void setMarkers() {
    markers = {};
    //POSICAO DO ESPACO ESPORTIVO
    markers.add(//MARKER PRINCIPAL
        Marker(
      markerId: MarkerId("CURRENTPOSITION"),
      position: geoPosition,
      onTap: () {},
    ));
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
