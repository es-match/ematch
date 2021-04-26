import 'package:ematch/App/controller/locationController.dart';
import 'package:ematch/App/custom_widgets/locationEventtableCalendar.dart';
import 'package:ematch/App/model/locationModel.dart';
import 'package:ematch/App/view/OwnerViews/locationPage/editLocationAvaiability.dart';
import 'package:ematch/App/view/OwnerViews/locationPage/locationCalendarPage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EditLocationPage extends StatefulWidget {
  final LocationModel locationModel;

  const EditLocationPage({this.locationModel});

  @override
  _EditLocationPageState createState() => _EditLocationPageState();
}

class _EditLocationPageState extends State<EditLocationPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _cep = TextEditingController();
  final TextEditingController _cidade = TextEditingController();
  final TextEditingController _endereco = TextEditingController();
  final TextEditingController _numero = TextEditingController();

  GoogleMapController googleMapController;
  LocationController locationController;
  LatLng _currPosition;
  Set<Marker> marker = Set();

  bool isEditMode;

  @override
  void initState() {
    super.initState();
    locationController = LocationController(
        name: _name,
        cep: _cep,
        city: _cidade,
        address: _endereco,
        number: _numero);

    locationController.name.text = widget.locationModel.locationName;
    locationController.cep.text = widget.locationModel.zip;
    locationController.city.text = widget.locationModel.city;
    locationController.address.text = widget.locationModel.address;
    locationController.number.text = widget.locationModel.number;

    isEditMode = false;

    _currPosition = LatLng(widget.locationModel.geolocation.dLatitude,
        widget.locationModel.geolocation.dLongitude);
    setMarker();
  }

  void setMarker() {
    marker = {};
    //ADICIONA POSICAO ATUAL
    marker.add(//MARKER PRINCIPAL
        Marker(
      markerId: MarkerId("currentPosition"),
      position: _currPosition,
      onTap: () {
        print('Tapped');
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Editar Local"),
        ),
        body: Builder(builder: (context) {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 6,
                        child: Column(
                          children: [
                            Text("Nome da Quadra"),
                            TextField(
                              readOnly: !isEditMode,
                              controller: locationController.name,
                            ),
                            Text("CEP"),
                            TextField(
                              readOnly: !isEditMode,
                              controller: locationController.cep,
                            ),
                            Text("Cidade"),
                            TextField(
                              readOnly: !isEditMode,
                              controller: locationController.city,
                            ),
                            Text("Endereço"),
                            TextField(
                              readOnly: !isEditMode,
                              controller: locationController.address,
                            ),
                            Text("Número"),
                            TextField(
                              readOnly: !isEditMode,
                              keyboardType: TextInputType.number,
                              controller: locationController.number,
                            ),
                            Container(
                              height: 250,
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(
                                    target: _currPosition, zoom: 14),
                                onMapCreated: (controller) {
                                  googleMapController = controller;
                                },
                                markers: marker,
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomRight,
                                // ignore: deprecated_member_use
                                child: isEditMode == true
                                    ? buildEditModeButtons(context)
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditLocationAvaiability(
                                                              widget
                                                                  .locationModel)));
                                            },
                                            child: Text("Horários"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LocationCalendarPage(
                                                    // LocationEventtableCalendar(
                                                    futureEvents:
                                                        locationController
                                                            .getLocationEvents(
                                                                widget
                                                                    .locationModel
                                                                    .id),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Text("Calendário"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                isEditMode = true;
                                              });
                                            },
                                            child: Text("Editar Dados"),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          );
        }));
  }

  Row buildEditModeButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () => {
            (_name.text.isEmpty ||
                    _cep.text.isEmpty ||
                    _cidade.text.isEmpty ||
                    _endereco.text.isEmpty ||
                    _numero.text.isEmpty)
                ? Scaffold.of(context)
                    // ignore: deprecated_member_use
                    .showSnackBar(SnackBar(
                    content: Text('Preenchar todos os campos'),
                    action: SnackBarAction(
                      label: 'OK',
                      onPressed: () {
                        setState(() {
                          isEditMode = true;
                        });
                        // Some code to undo the change.
                      },
                    ),
                  ))
                : locationController.editLocation(widget.locationModel.id)
          },
          child: Text("Finalizar"),
        ),
        SizedBox(
          width: 10,
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              isEditMode = false;
            });
          },
          child: Text("Cancelar"),
        ),
      ],
    );
  }
}
