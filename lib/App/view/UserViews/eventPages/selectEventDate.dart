import 'package:ematch/App/controller/locationController.dart';
import 'package:ematch/App/custom_widgets/locationEventtableCalendar.dart';
import 'package:ematch/App/custom_widgets/table_calendar_example.dart';
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
  @override
  void initState() {
    // TODO: implement initState
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
            ]),
      ),
    );
  }

  Container buildCalendarTable(BuildContext context) {
    return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LocationEventtableCalendar(
                      futureEvents: locationController
                          .getLocationEvents(widget.location.id)),
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
      // height: MediaQuery.of(context).size.height * 0.6,
      // width: MediaQuery.of(context).size.width,
      child: Text("Valor Por hora: ${widget.location.hourValue}"),
      // Card(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.stretch,
      //     children: [
      //       Text("Valor Por hora: ${widget.location.hourValue}"),
      //     ],
      //   ),
      // ),
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
