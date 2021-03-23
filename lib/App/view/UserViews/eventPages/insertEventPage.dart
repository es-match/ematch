import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:haversine_distance/haversine_distance.dart';
import 'package:geocoder/geocoder.dart';
import 'dart:math' as math;

class InsertEventPage extends StatefulWidget {
  @override
  _InsertEventPageState createState() => _InsertEventPageState();
}

class _InsertEventPageState extends State<InsertEventPage> {
  double _currentSliderValue = 50;
  String dropdownValue = "";
  List<String> hours = ["01:00 - 02:00", "02:00 - 03:00"];

  GoogleMapController googleMapController;
  CalendarController _calendarController = CalendarController();
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  //Usado para calculo de distancia no mapa
  final haversineDistance = HaversineDistance();

  Future<void> _future;

  LatLng _initialPosition;
  double _circleRadius = 0;
  @override
  void initState() {
    super.initState();

    //PEGA LOCALIZACAO ATUAL DO USUARIO
    _future = _getGeolocation();

    //HORARIOS
    dropdownValue = hours[0];
  }

  Future<void> _getGeolocation() async {
    final query = "Rua viktor augusto stroka 499 sorocaba";
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    setState(() {
      // _initialPosition = LatLng(position.latitude, position.longitude);
      print(first.coordinates);
      // _initialPosition = LatLng(-23.505352, -47.453409);
      _initialPosition =
          LatLng(first.coordinates.latitude, first.coordinates.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo Evento"),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return buildBody();
          else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Padding buildBody() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(alignment: Alignment.topCenter, child: Text("Locais")),
          Divider(),
          //SLIDER DE DISTANCIA
          buildDistanceSlider(),
          Expanded(
            child: buildGoogleMap(),
          ),
          //LISTA DE EVENTOS
          buildEventListView(),
          //TODO: FINALIZAR CALENDARIO
          // buildCalendar(),
          SizedBox(height: 8),
          // buildHourDropDownButton(),
          // buildHourDropDownButton(),
        ],
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

  DropdownButton<String> buildHourDropDownButton() {
    return DropdownButton(
      value: dropdownValue,
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: hours.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Expanded buildEventListView() {
    return Expanded(
        // height: 300,
        // height: MediaQuery.of(context).size.height,
        child: ScrollablePositionedList.builder(
      itemScrollController: itemScrollController,
      itemPositionsListener: itemPositionsListener,
      itemCount: 2,
      itemBuilder: (context, index) {
        return ExpansionTile(
          onExpansionChanged: (value) {
            if (value)
              itemScrollController.scrollTo(
                  index: index, duration: Duration(milliseconds: 5));

            return value;
          },
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.run_circle_outlined,
                ),
              ),
              Column(
                children: [Text("PaintBall World $index")],
              ),
            ],
          ),
          children: [
            // SizedBox(
            //   width: MediaQuery.of(context).size.width,
            //   height: MediaQuery.of(context).size.width,
            //   child: buildGoogleMap(index),
            // ),

            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                child: Text("Agendar horário"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InsertEventPage()),
                  );
                },
              ),
            )
            // buildCalendar(),
            // buildHourDropDownButton(),
            // buildHourDropDownButton(),
          ],
        );
      },
    ));
  }

  GoogleMap buildGoogleMap({int index = 0}) {
    return GoogleMap(
      onCameraMove: (position) => {},
      mapToolbarEnabled: false,
      // zoomControlsEnabled: false,
      zoomGesturesEnabled: false,
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(target: _initialPosition, zoom: 14),
      markers: {
        //MARKER PRINCIPAL
        Marker(
          markerId: MarkerId(index.toString()),
          position: _initialPosition,
          onTap: () {},
        ),

        Marker(
          markerId: MarkerId('$index aux1'),
          position: LatLng(-23.496501, -47.459765),
          alpha: locationInRange(
              _initialPosition, LatLng(-23.496501, -47.459765), _circleRadius),
        ),

        Marker(
          markerId: MarkerId('$index aux2'),
          position: LatLng(-23.492987, -47.463646),
          alpha: locationInRange(
              _initialPosition, LatLng(-23.492987, -47.463646), _circleRadius),
        ),

        Marker(
          markerId: MarkerId('$index aux3'),
          position: LatLng(-23.504725, -47.463079),
          alpha: locationInRange(
              _initialPosition, LatLng(-23.504725, -47.463079), _circleRadius),
        ),
        Marker(
          markerId: MarkerId('$index aux4'),
          position: LatLng(-23.505139, -47.455593),
          alpha: locationInRange(
              _initialPosition, LatLng(-23.505139, -47.455593), _circleRadius),
        ),

        Marker(
          markerId: MarkerId('$index aux5'),
          position: LatLng(-23.519244, -47.438434),
          alpha: locationInRange(
              _initialPosition, LatLng(-23.519244, -47.438434), _circleRadius),
        ),
        Marker(
          markerId: MarkerId('$index aux6'),
          position: LatLng(-23.544338, -47.505966),
          alpha: locationInRange(
              _initialPosition, LatLng(-23.544338, -47.505966), _circleRadius),
        ),
        Marker(
          markerId: MarkerId('$index aux7'),
          position: LatLng(-23.434137, -47.336185),
          alpha: locationInRange(
              _initialPosition, LatLng(-23.434137, -47.336185), _circleRadius),
        ),
      },
      circles: {
        Circle(
            circleId: CircleId(index.toString()),
            center: _initialPosition,
            radius: _circleRadius,
            fillColor: Colors.orange.withOpacity(0.5),
            strokeWidth: 3,
            strokeColor: Colors.orange[100]),
      },
      onMapCreated: (controller) {
        googleMapController = controller;
      },
    );
  }

  Row buildDistanceSlider() {
    return Row(
      children: [
        Text("Distância: "),
        Expanded(
          child: Slider(
            min: 1,
            max: 100,
            divisions: 198,
            label: "${_currentSliderValue.toStringAsFixed(2)} km",
            value: _currentSliderValue,
            onChanged: (value) {
              setState(() {
                _currentSliderValue = value;
                _circleRadius = value * 1000;

                googleMapController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: _initialPosition,
                      zoom: getZoomLevel(_circleRadius),
                    ),
                  ),
                );
              });
            },
          ),
        )
      ],
    );
  }

  double locationInRange(LatLng posA, LatLng posB, double target) {
    Location lA = Location(posA.latitude, -posA.longitude);
    Location lB = Location(posB.latitude, -posB.longitude);

    double value = haversineDistance.haversine(lA, lB, Unit.METER);
    return value <= target ? 0.5 : 0;
  }

  double getZoomLevel(double circleRadius) {
    double zoomLevel = 11;
    double radius = circleRadius + circleRadius / 2;
    double scale = radius / 500;
    zoomLevel = (16 - math.log(scale) / math.log(2));

    return zoomLevel;
  }
}
