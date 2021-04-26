import 'package:ematch/App/controller/locationController.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_cep/search_cep.dart';
import 'package:geocoder/geocoder.dart';

class InsertLocationPage extends StatefulWidget {
  @override
  _InsertLocationPageState createState() => _InsertLocationPageState();
}

class _InsertLocationPageState extends State<InsertLocationPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _cep = TextEditingController();
  final TextEditingController _cidade = TextEditingController();
  final TextEditingController _endereco = TextEditingController();
  final TextEditingController _numero = TextEditingController();

  Set<Marker> marker = Set();

  LocationController locationController;
  GoogleMapController googleMapController;
  LatLng _currPosition;
  @override
  void initState() {
    super.initState();
    locationController = LocationController(
        name: _name,
        cep: _cep,
        city: _cidade,
        address: _endereco,
        number: _numero);
    asyncMethods();
  }

  void asyncMethods() async {
    Position pos = await _getGeolocation();
    LatLng coord = LatLng(pos.latitude, pos.longitude);
    // List<LocationModel> locals = await _getLocationDistances();
    setState(() {
      _currPosition = coord;
      // locationList = locals;
      // setMarkers(locationList);
    });
  }

  Future<Position> _getGeolocation() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Adicionar novo Local"),
        ),
        body: _currPosition == null
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(child: buildBody(context)));
  }

  Container buildBody(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                flex: 6,
                child: Column(
                  children: [
                    Text("Nome da Quadra"),
                    TextField(
                      controller: locationController.name,
                    ),
                    Text("CEP"),
                    TextField(
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                        getLocationByCep(value);

                        setState(() {
                          googleMapController.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                  target: _currPosition, zoom: 19)));
                          setMarker();
                        });
                      },
                      // decoration: InputDecoration(
                      //   border: InputBorder.none,
                      //   prefixIcon: Icon(Icons.search),
                      //   hintText: 'Search ',
                      //   contentPadding:
                      //       EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      // ),
                      controller: locationController.cep,
                    ),
                    Container(
                      height: 200,
                      child: GoogleMap(
                        initialCameraPosition:
                            CameraPosition(target: _currPosition, zoom: 14),
                        onMapCreated: (controller) {
                          googleMapController = controller;
                        },
                        markers: marker,
                      ),
                    ),
                    Text("Cidade"),
                    TextField(
                      controller: locationController.city,
                    ),
                    Text("Endereço"),
                    TextField(
                      controller: locationController.address,
                    ),
                    Text("Número"),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: locationController.number,
                    ),
                  ],
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () => locationController.insertLocation(),
                child: Text("Criar espaço esportivo"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setMarker() {
    marker = {};
    //ADICIONA POSICAO ATUAL
    marker.add(//MARKER PRINCIPAL
        Marker(
      position: _currPosition,
      onTap: () {
        print('Tapped');
      },
      draggable: true,
      markerId: MarkerId('Marker'),
      onDragEnd: ((newPos) {
        _currPosition = LatLng(newPos.latitude, newPos.longitude);
        googleMapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: _currPosition, zoom: 19)));
        getLocationByCoordinate(_currPosition);
      }),
    ));
  }

  void getLocationByCoordinate(LatLng position) async {
    Coordinates coordinate = Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinate);
    var first = addresses.first;
    print("${first.featureName} : ${first.addressLine}");
  }

  void getLocationByCep(String cepValue) async {
    try {
      final viaCepSearchCep = ViaCepSearchCep();
      final optionRes = await viaCepSearchCep.searchInfoByCep(
          cep: cepValue, returnType: SearchInfoType.piped);

      final infoCepJSON = optionRes.getOrElse(() => null);
      var addresses = await Geocoder.local.findAddressesFromQuery(cepValue);
      var first = addresses.first;
      _cidade.text = infoCepJSON.localidade;
      _endereco.text = infoCepJSON.logradouro;
      // _numero.text = infoCepJSON.
      _currPosition =
          LatLng(first.coordinates.latitude, first.coordinates.longitude);
      // print(infoCepJSON);
      // print("${first.featureName} : ${first.coordinates}");
    } on Exception catch (e) {
      print("ERRO: $e");
    }
  }
}
