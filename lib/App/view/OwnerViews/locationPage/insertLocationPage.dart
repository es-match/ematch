import 'package:ematch/App/controller/locationController.dart';
import 'package:flutter/material.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Adicionar novo Local"),
        ),
        body: Container(
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
                    onPressed: () => locationController.insertLocation(),
                    child: Text("Criar espaço esportivo"),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
