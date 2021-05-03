import 'package:ematch/App/controller/locationController.dart';
import 'package:ematch/App/model/locationModel.dart';
import 'package:ematch/App/view/UserViews/eventPages/selectEventDate.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:haversine_distance/haversine_distance.dart';
import 'dart:math' as math;
// import 'package:table_calendar/table_calendar.dart';

class SelectEventLocationPage extends StatefulWidget {
  @override
  _SelectEventLocationPageState createState() =>
      _SelectEventLocationPageState();
}

class _SelectEventLocationPageState extends State<SelectEventLocationPage> {
  double _currentSliderValue = 50;
  String dropdownValue = "";  
  GoogleMapController googleMapController;
  LocationController locationController = LocationController();

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  LatLng _initialPosition;
  List<LocationModel> locationList = [];
  //Usado para calculo de distancia no mapa
  final haversineDistance = HaversineDistance();

  double _circleRadius = 0;
  Set<Marker> markers = Set();
  @override
  void initState() {
    super.initState();
    _currentSliderValue = 1;
    _circleRadius = 1000;
    asyncMethods();
    // _getGeolocation();
    // _getLocationDistances();
  }

  void asyncMethods() async {
    Position pos = await _getGeolocation();
    LatLng coord = LatLng(pos.latitude, pos.longitude);
    List<LocationModel> locals = await _getLocationDistances();
    setState(() {
      _initialPosition = coord;
      locationList = locals;
      setMarkers(locationList);
    });
  }   

  Future<List<LocationModel>> _getLocationDistances() async {
    return locationController.getLocations();
    // // .then((value) {
    // //   setState(() {
    // //     setMarkers(value);
    // //   });
    // });
  }

  Future<Position> _getGeolocation() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true);
    //   //   .then((pos) {
    //   // setState(() {
    //   //   _initialPosition = LatLng(pos.latitude, pos.longitude);
    //   // });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text("Novo Evento"),
      ),
      body: DefaultTextStyle(
          style: TextStyle(
            color: Colors.white,
          ),
          child: buildBody()),
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
            child: _initialPosition == null
                ? Center(child: CircularProgressIndicator())
                : buildGoogleMap(),
          ),
          //LISTA DE EVENTOS
          Container(child: buildEventListView()),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  Expanded buildEventListView() {
    // List<LocationModel>
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[900],
            border: Border.all(
              width: 1,
            )),
        child: ScrollablePositionedList.builder(
          itemScrollController: itemScrollController,
          itemPositionsListener: itemPositionsListener,
          itemCount: locationList.length,
          // ignore: missing_return
          itemBuilder: (context, index) {
            LocationModel currLocation = locationList[index];
            LatLng indexLocation = LatLng(currLocation.geolocation.dLatitude,
                currLocation.geolocation.dLongitude);
            if (locationInRange(
                    _initialPosition, indexLocation, _circleRadius) >
                0) {
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
                      children: [
                        Text(
                          currLocation.locationName,
                        ),
                      ],
                    ),
                  ],
                ),
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      child: Text("Agendar horário"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SelectEventDate(location: currLocation)),
                        );
                      },
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  GoogleMap buildGoogleMap({int index = 0}) {
    return GoogleMap(
      onCameraMove: (position) => {},
      mapToolbarEnabled: false,
      // zoomControlsEnabled: false,
      zoomGesturesEnabled: false,
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(target: _initialPosition, zoom: 14),
      markers: markers,
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

                //ATUALIZA MARCADORES NO MAPA
                setMarkers(locationList);

                //CONTROLE DE ZOOM POR SLIDER
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
    Location lA = Location(posA.latitude, posA.longitude);
    Location lB = Location(posB.latitude, posB.longitude);

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
    markers = {};
    //ADICIONA POSICAO ATUAL
    markers.add(//MARKER PRINCIPAL
        Marker(
      markerId: MarkerId("CURRENTPOSITION"),
      position: _initialPosition,
      onTap: () {},
    ));

    data.forEach((model) {
      try {
        LatLng modelLocation =
            LatLng(model.geolocation.dLatitude, model.geolocation.dLongitude);
        markers.add(
          Marker(
            markerId: MarkerId(model.id),
            position: modelLocation,
            alpha:
                locationInRange(_initialPosition, modelLocation, _circleRadius),
          ),
        );
      } catch (Exception) {
        print("error in model ${model.id}");
      }
    });
  }
}