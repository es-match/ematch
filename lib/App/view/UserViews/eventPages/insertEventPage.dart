import 'package:ematch/App/controller/locationController.dart';
import 'package:ematch/App/model/locationModel.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:haversine_distance/haversine_distance.dart';
import 'dart:math' as math;
// import 'package:table_calendar/table_calendar.dart';

class InsertEventPage extends StatefulWidget {
  @override
  _InsertEventPageState createState() => _InsertEventPageState();
}

class _InsertEventPageState extends State<InsertEventPage> {
  double _currentSliderValue = 50;
  String dropdownValue = "";
  List<String> hours = ["01:00 - 02:00", "02:00 - 03:00"];

  GoogleMapController googleMapController;
  LocationController locationController = LocationController();

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  LatLng _initialPosition;
  //Usado para calculo de distancia no mapa
  final haversineDistance = HaversineDistance();
  Future<void> _futureGetGeoLocation;
  Future<void> _futureGetLocationDistances;

  double _circleRadius = 0;
  Set<Marker> markers = Set();
  @override
  void initState() {
    super.initState();
    _currentSliderValue = 1;
    _circleRadius = 1000;
    // _futureGetGeoLocation = _getGeolocation();
    _futureGetLocationDistances = _getLocationDistances();

    //HORARIOS
    dropdownValue = hours[0];
  }

  Future<List<LocationModel>> _getLocationDistances() async {
    return locationController.getLocations();
  }

  // ignore: unused_element
  Future<Position> _getGeolocation() async {
    // final query = "Rua viktor augusto stroka 499 sorocaba";
    // var addresses = await Geocoder.local.findAddressesFromQuery(query);
    // var first = addresses.first;
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Novo Evento"),
        ),
        // ignore: missing_required_param
        body: FutureBuilder(
          future:
              Future.wait([_futureGetGeoLocation, _futureGetLocationDistances]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Position position = snapshot.data[0];
              _initialPosition = LatLng(position.latitude, position.longitude);
              // _initialPosition = LatLng(-23.5257412, -47.4936445);
              // setMarkers(snapshot.data[1]);
              return buildBody();
            } else
              return Center(child: CircularProgressIndicator());
          },
        ));
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
          SizedBox(height: 8),
          // buildHourDropDownButton(),
          // buildHourDropDownButton(),
        ],
      ),
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
      // markers: markers,
      // circles: {
      //   Circle(
      //       circleId: CircleId(index.toString()),
      //       center: _initialPosition,
      //       radius: _circleRadius,
      //       fillColor: Colors.orange.withOpacity(0.5),
      //       strokeWidth: 3,
      //       strokeColor: Colors.orange[100]),
      // },
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
    double result = value <= target ? 0.5 : 0;
    return result;
  }

  double getZoomLevel(double circleRadius) {
    double zoomLevel = 11;
    double radius = circleRadius + circleRadius / 2;
    double scale = radius / 500;
    zoomLevel = (16 - math.log(scale) / math.log(2));

    return zoomLevel;
  }

  setMarkers(List<LocationModel> data) {
    //ADICIONA POSICAO ATUAL
    markers.add(//MARKER PRINCIPAL
        Marker(
      markerId: MarkerId("CURRENTPOSITION"),
      position: _initialPosition,
      onTap: () {},
    ));

    data.forEach((model) {
      //TODO: VERIFICAR ERRO
      try {
        LatLng modelLocation =
            LatLng(model.geolocation.dLatitude, model.geolocation.dLongitude);
        markers.add(
          Marker(
            markerId: MarkerId(model.id),
            position: modelLocation,
            alpha:
                // locationInRange(_initialPosition, modelLocation, _circleRadius),
                locationInRange(LatLng(-23.5257412, -47.4936445), modelLocation,
                    _circleRadius),
          ),
        );
      } catch (Exception) {
        print("error");
      }
    });

    // markers.addAll([
    // Marker(
    //   markerId: MarkerId('$index aux1'),
    //   position: LatLng(-23.496501, -47.459765),
    //   alpha: locationInRange(
    //       _initialPosition, LatLng(-23.496501, -47.459765), _circleRadius),
    // ),

    // Marker(
    //   markerId: MarkerId('$index aux2'),
    //   position: LatLng(-23.492987, -47.463646),
    //   alpha: locationInRange(
    //       _initialPosition, LatLng(-23.492987, -47.463646), _circleRadius),
    // ),

    // Marker(
    //   markerId: MarkerId('$index aux3'),
    //   position: LatLng(-23.504725, -47.463079),
    //   alpha: locationInRange(
    //       _initialPosition, LatLng(-23.504725, -47.463079), _circleRadius),
    // ),

    //NAO SETADOS LOCALIZACAO NO FIREBASE
    // Marker(
    //   markerId: MarkerId('$index aux4'),
    //   position: LatLng(-23.505139, -47.455593),
    //   alpha: locationInRange(
    //       _initialPosition, LatLng(-23.505139, -47.455593), _circleRadius),
    // ),

    // Marker(
    //   markerId: MarkerId('$index aux5'),
    //   position: LatLng(-23.519244, -47.438434),
    //   alpha: locationInRange(
    //       _initialPosition, LatLng(-23.519244, -47.438434), _circleRadius),
    // ),
    // Marker(
    //   markerId: MarkerId('$index aux6'),
    //   position: LatLng(-23.544338, -47.505966),
    //   alpha: locationInRange(
    //       _initialPosition, LatLng(-23.544338, -47.505966), _circleRadius),
    // ),
    // Marker(
    //   markerId: MarkerId('$index aux7'),
    //   position: LatLng(-23.434137, -47.336185),
    //   alpha: locationInRange(
    //       _initialPosition, LatLng(-23.434137, -47.336185), _circleRadius),
    // )
    // ]);
  }
}
