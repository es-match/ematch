import 'package:ematch/App/controller/locationController.dart';
import 'package:ematch/App/model/locationModel.dart';
import 'package:flutter/material.dart';

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

  LocationController locationController;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Editar Local"),
        ),
        body: Builder(builder: (context) {
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
                            controller: locationController.cep,
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
                    child: RaisedButton(
                      onPressed: () => {
                        (_name.text.isEmpty ||
                                _cep.text.isEmpty ||
                                _cidade.text.isEmpty ||
                                _endereco.text.isEmpty ||
                                _numero.text.isEmpty)
                            ? Scaffold.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('Por favor preencha todos os campos'),
                                action: SnackBarAction(
                                  label: 'OK',
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                ),
                              ))
                            : locationController
                                .editLocation(widget.locationModel.id)
                      },
                      child:
                          Text("Editar ${widget.locationModel.locationName}"),
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
