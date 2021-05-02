import 'package:ematch/App/controller/locationController.dart';
import 'package:ematch/App/custom_widgets/ownerLocationEventtableCalendar.dart';
import 'package:ematch/App/model/locationModel.dart';
import 'package:ematch/App/view/OwnerViews/locationPage/editLocationAvaiability.dart';
import 'package:ematch/App/view/OwnerViews/locationPage/locationCalendarPage.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
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
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

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
          title: Column(
            children: [
              Text(widget.locationModel.locationName),
              // Text(
              //   "(Detalhes do Local)",
              //   style: TextStyle(
              //     color: Colors.grey[200],
              //   ),
              // ),
            ],
          ),
        ),
        bottomNavigationBar: isEditMode == true
            ? null
            : Row(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => EditLocationAvaiability(
                      //                 widget.locationModel)));
                      //   },
                      //   child: Text("Horários"),
                      // ),
                      Container(
                        height: MediaQuery.of(context).size.height / 12,
                        width: MediaQuery.of(context).size.width / 2,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LocationCalendarPage(
                                  location: widget.locationModel,
                                  // LocationEventtableCalendar(
                                  // futureEvents:
                                  //     locationController.getLocationEvents(
                                  //         widget.locationModel.id),
                                ),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.calendar_today),
                              Text(
                                "Calendário",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 12,
                        width: MediaQuery.of(context).size.width / 2,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isEditMode = true;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.edit),
                              Text(
                                "Editar Dados",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
        body: Builder(builder: (context) {
          return SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 170,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      widget.locationModel.imageUrl,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: MediaQuery.of(context).size.height / 1.2,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextFormField(
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    readOnly: !isEditMode,
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
                                        fontSize: 18,
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
                                  TextFormField(
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    readOnly: !isEditMode,
                                    controller: locationController.cep,
                                    validator: MultiValidator([
                                      RequiredValidator(
                                        errorText: "Campo Obrigatório",
                                      )
                                    ]),
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      alignLabelWithHint: true,
                                      labelText: 'CEP',
                                      labelStyle: TextStyle(
                                        fontSize: 18,
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
                                  TextFormField(
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    readOnly: !isEditMode,
                                    controller: locationController.city,
                                    validator: MultiValidator([
                                      RequiredValidator(
                                        errorText: "Campo Obrigatório",
                                      )
                                    ]),
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      alignLabelWithHint: true,
                                      labelText: 'Cidade',
                                      labelStyle: TextStyle(
                                        fontSize: 18,
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
                                  TextFormField(
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    readOnly: !isEditMode,
                                    controller: locationController.address,
                                    validator: MultiValidator([
                                      RequiredValidator(
                                        errorText: "Campo Obrigatório",
                                      )
                                    ]),
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      alignLabelWithHint: true,
                                      labelText: 'Endereço',
                                      labelStyle: TextStyle(
                                        fontSize: 18,
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
                                  TextFormField(
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    readOnly: !isEditMode,
                                    keyboardType: TextInputType.number,
                                    controller: locationController.number,
                                    validator: MultiValidator([
                                      RequiredValidator(
                                        errorText: "Campo Obrigatório",
                                      )
                                    ]),
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      alignLabelWithHint: true,
                                      labelText: 'Número',
                                      labelStyle: TextStyle(
                                        fontSize: 18,
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
                                  Align(
                                      alignment: Alignment.bottomCenter,

                                      // ignore: deprecated_member_use
                                      child: isEditMode == true
                                          ? buildEditModeButtons(context)
                                          : null),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }

  Container buildEditModeButtons(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.save),
                Text(
                  "Salvar",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isEditMode = false;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.cancel),
                Text(
                  "Cancelar",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
