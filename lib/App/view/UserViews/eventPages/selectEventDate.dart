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
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: GoogleMap(
                  onCameraMove: (position) => {},
                  mapToolbarEnabled: false,
                  // zoomControlsEnabled: false,
                  zoomGesturesEnabled: false,
                  mapType: MapType.normal,
                  initialCameraPosition:
                      CameraPosition(target: geoPosition, zoom: 14),
                  markers: markers,
                  onMapCreated: (controller) {
                    googleMapController = controller;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(),
              ),
              buildLocationValues(),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: TableCalendarexample(), //buildCalendar(),
              ),
            ]),
      ),
    );
  }

  Container buildLocationValues() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Local"),
            Text("Valor Por hora: xxx"),
          ],
        ),
      ),
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
