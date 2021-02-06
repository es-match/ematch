import 'package:flutter/material.dart';

class NewGroupPage extends StatefulWidget {
  @override
  _NewGroupPageState createState() => _NewGroupPageState();
}

final List<String> esportes = [
  'Futebol',
  'Basquete',
  'Paintball',
];

class _NewGroupPageState extends State<NewGroupPage> {
  String _esportes = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Grupo ${DateTime.now().second.toString()}'),
      ),
      body: buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print("TESTE"),
        child: Text("Criar"),
      ),
    );
  }

  ListView buildBody() {
    return ListView(
      children: [
        ListTile(
          title: Column(
            children: [
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: Text('Título do Grupo'),
              // ),
              TextField(
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Título do Grupo',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(),
              ),
              TextField(
                maxLines: 5,
                maxLength: 50,
                decoration: InputDecoration(
                  labelText: 'Descrição do Grupo',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.orangeAccent, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(),
              ),
              Text("Selecione o esporte"),
              Column(
                children: buildRadioList(),
              ),
              Divider(),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> buildRadioList() {
    var radiobuttons = <RadioListTile>[];

    esportes.forEach((element) {
      return radiobuttons.add(RadioListTile<String>(
        title: Text(element),
        value: element,
        groupValue: _esportes,
        onChanged: (String value) {
          setState(() {
            _esportes = value;
          });
        },
      ));
    });

    return radiobuttons;
  }

  //   return [
  //     RadioListTile(
  //       title: Text(esportes[0]),
  //       value: esportes[0],
  //       groupValue: _esportes,
  //       onChanged: (String value) {
  //         setState(() {
  //           _esportes = value;
  //         });
  //       },
  //     ),
  //     RadioListTile(
  //       title: Text(esportes[1]),
  //       value: esportes[1],
  //       groupValue: _esportes,
  //       onChanged: (String value) {
  //         setState(() {
  //           _esportes = value;
  //         });
  //       },
  //     ),
  //   ];
  // }
}
