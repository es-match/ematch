import 'package:ematch/App/model/groupModel.dart';
import 'package:ematch/App/view/UserViews/eventPages/insertEventPage.dart';
import 'package:flutter/material.dart';

class GroupDetailsPage extends StatefulWidget {
  final GroupModel group;

  const GroupDetailsPage({this.group});

  @override
  _GroupDetailsPageState createState() => _GroupDetailsPageState();
}

class _GroupDetailsPageState extends State<GroupDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildTopImageWidget(context),
          buildDescription(),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 1, left: 8, right: 8, top: 3),
              child: Column(
                children: [
                  Text("Próximas Partidas"),
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                        ),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, index) => ListTile(
                          title: Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.black.withOpacity(0.5),
                                      width: 1),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          flex: 9,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons
                                                      .calendar_today_outlined),
                                                  Text("08/12, 19:00 - 21:00")
                                                ],
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                      "Paintball World - 5 km")),
                                            ],
                                          )),
                                      Expanded(
                                          flex: 3,
                                          child: Container(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.check_circle_outline,
                                                  color: Colors.green),
                                              Text("Confirmado")
                                            ],
                                          ))),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: buildBottomButtons(context),
    );
  }

  Padding buildDescription() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Descrição"),
          TextField(
            textInputAction: TextInputAction.done,
            maxLines: 5,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Stack buildTopImageWidget(BuildContext context) {
    return Stack(children: [
      Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
            widget.group.imageUrl,
            fit: BoxFit.none,
          ),
        ),
      ),
      Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              widget.group.groupName,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    ]);
  }

  Column buildBottomButtons(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          // ignore: deprecated_member_use
          child: RaisedButton(
            child: Text('Agendar Novo Evento'),
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InsertEventPage()),
              )
            },
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          // ignore: deprecated_member_use
          child: RaisedButton(
              child: Text('Ver Participantes do Grupo'), onPressed: () => {}),
        ),
      ],
    );
  }
}
