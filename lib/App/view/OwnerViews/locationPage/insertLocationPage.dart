import 'package:ematch/App/controller/locationController.dart';
import 'package:ematch/App/model/locationModel.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_cep/search_cep.dart';
import 'package:geocoder/geocoder.dart';

import 'editLocationPage.dart';

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
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

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
          : SingleChildScrollView(child: buildBody(context)),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (formkey.currentState.validate()) {
            formkey.currentState.save();
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Dialog(
                  backgroundColor: Colors.white60,
                  child: new Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      new CircularProgressIndicator(),
                      new SizedBox(
                        height: 10,
                      ),
                      new Text(" Criando espaço esportivo..."),
                    ],
                  ),
                );
              },
            );
            LocationModel location = await locationController.insertLocation();
            // GroupModel group = GroupModel();
            // group.groupName = tituloController.text;
            // group.groupDescription = descricaoController.text;
            // group.imageUrl = _selectedActivity.imageUrl;
            // group.activityID = _selectedActivity.id;
            // group.groupPending = [];
            // group.groupAdmins = [myUserid];
            // group.userCreator = myUserid;
            // group.groupUsers = [myUserid];
            // group = await groupController.insertGroup(group);

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EditLocationPage(locationModel: location),
                ));
          }
        },

        child: Icon(
          Icons.add,
          size: 32,
        ),
        // child: Text(
        //   "+",
        //   style: TextStyle(
        //     fontSize: 50,
        //   ),
        // ),
      ),
    );
  }

  Container buildBody(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        controller: locationController.name,
                        validator: MultiValidator([
                          RequiredValidator(
                            errorText: "Campo Obrigatório",
                          )
                        ]),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          alignLabelWithHint: true,
                          labelText: 'Nome da Quadra',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.deepOrange,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[800],
                              width: 1.0,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.redAccent[700],
                              width: 1.0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.deepOrange,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        validator: MultiValidator([
                          RequiredValidator(
                            errorText: "Campo Obrigatório",
                          )
                        ]),
                        textInputAction: TextInputAction.search,
                        onFieldSubmitted: (value) {
                          if (value != null && value.length > 7) {
                            getLocationByCep(value);
                          }
                          setState(() {
                            googleMapController.animateCamera(
                                CameraUpdate.newCameraPosition(CameraPosition(
                                    target: _currPosition, zoom: 19)));
                            setMarker();
                          });
                        },
                        controller: locationController.cep,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          alignLabelWithHint: true,
                          labelText: 'CEP',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.deepOrange,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[800],
                              width: 1.0,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.redAccent[700],
                              width: 1.0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.deepOrange,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        validator: MultiValidator([
                          RequiredValidator(
                            errorText: "Campo Obrigatório",
                          )
                        ]),
                        controller: locationController.city,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          alignLabelWithHint: true,
                          labelText: 'Cidade',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.deepOrange,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[800],
                              width: 1.0,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.redAccent[700],
                              width: 1.0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.deepOrange,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        validator: MultiValidator([
                          RequiredValidator(
                            errorText: "Campo Obrigatório",
                          )
                        ]),
                        controller: locationController.address,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          alignLabelWithHint: true,
                          labelText: 'Endereço',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.deepOrange,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[800],
                              width: 1.0,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.redAccent[700],
                              width: 1.0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.deepOrange,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        validator: MultiValidator([
                          RequiredValidator(
                            errorText: "Campo Obrigatório",
                          )
                        ]),
                        keyboardType: TextInputType.number,
                        controller: locationController.number,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          alignLabelWithHint: true,
                          labelText: 'Número',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.deepOrange,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[800],
                              width: 1.0,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.redAccent[700],
                              width: 1.0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.deepOrange,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
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
                    ],
                  )),
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: ElevatedButton(
              //     onPressed: () => locationController.insertLocation(),
              //     child: Text("Criar espaço esportivo"),
              //   ),
              // ),
            ],
          ),
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
