import 'package:ematch/App/custom_widgets/eventCard.dart';
import 'package:ematch/App/model/eventModel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventDetailPage extends StatefulWidget {
  final EventModel model;

  const EventDetailPage({Key key, this.model}) : super(key: key);

  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  LatLng locationPosition;
  GoogleMapController googleMapController;
  Set<Marker> marker = Set();
  @override
  void initState() {
    super.initState();
    locationPosition = LatLng(widget.model.geolocation.dLatitude,
        widget.model.geolocation.dLongitude);
    setMarker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do Evento"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EventCard(event: widget.model),
            Text(widget.model.address),
            Divider(),
            buildGoogleMap(),
            
          ],
        ),
      ),
    );
  }

  Container buildGoogleMap() {
    return Container(
            height: 200,
            child: GoogleMap(
              onCameraMove: (position) => {},
              mapToolbarEnabled: false,
              // zoomControlsEnabled: false,
              zoomGesturesEnabled: false,
              mapType: MapType.normal,
              initialCameraPosition:
                  CameraPosition(target: locationPosition, zoom: 14),
              markers: marker,             
              onMapCreated: (controller) {
                googleMapController = controller;
              },
            ),
          );
  }

  void setMarker() {
    marker = {};
    //POSICAO DO ESPACO ESPORTIVO
    marker.add(//MARKER PRINCIPAL
        Marker(
      markerId: MarkerId("CURRENTPOSITION"),
      position: locationPosition,
      onTap: () {},
    ));
  }
}
