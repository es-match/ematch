import 'package:ematch/App/controller/eventController.dart';
import 'package:ematch/App/model/eventModel.dart';
import 'package:ematch/App/model/groupModel.dart';
import 'package:ematch/App/view/UserViews/eventPages/insertEventPage.dart';
import 'package:ematch/App/view/UserViews/group/groupParticipantsPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GroupDetailsPage extends StatefulWidget {
  final GroupModel group;

  GroupDetailsPage({this.group});

  @override
  _GroupDetailsPageState createState() => _GroupDetailsPageState();
}

class _GroupDetailsPageState extends State<GroupDetailsPage> {
  EventController eventController = EventController();
  Future<List<EventModel>> _getEventsByGroupID;
  List<EventModel> events;

  @override
  void initState() {
    super.initState();
    _getEventsByGroupID = eventController.getEventsByGroupID(widget.group.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Informações do Grupo"),
      ),
      body: FutureBuilder(
        future: Future.wait([_getEventsByGroupID]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            events = snapshot.data[0];
            return buildBody(context);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: buildBottomButtons(context),
    );
  }

  Column buildBody(BuildContext context) {
    return Column(
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
                Text("Próximos Eventos"),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                      ),
                    ),
                    child: ListView.builder(
                      // shrinkWrap: true,
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        EventModel currEvent = events[index];
                        var eventName = currEvent.eventName;
                        var startDay = DateFormat("dd/MM")
                            .format(DateTime.parse(currEvent.startDate));
                        var endDay = DateFormat("dd/MM")
                            .format(DateTime.parse(currEvent.endDate));
                        var startTime = DateFormat("HH:mm")
                            .format(DateTime.parse(currEvent.startDate));
                        var endTime = DateFormat("HH:mm")
                            .format(DateTime.parse(currEvent.endDate));
                        return ListTile(
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
                                                  Text(
                                                      "$startDay, $startTime - $endTime")
                                                ],
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                      "$eventName - 5 km")),
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
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
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
            enabled: false,
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
            child: Text('Ver Participantes do Grupo'),
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GroupParticipantsPage(
                        adminList: widget.group.groupAdmins,
                        pendingList: widget.group.groupPending,
                        userList: widget.group.groupUser)),
              ),
            },
          ),
        ),
      ],
    );
  }
}
