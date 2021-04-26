import 'package:ematch/App/controller/eventController.dart';
import 'package:ematch/App/controller/groupController.dart';
import 'package:ematch/App/controller/sign_in.dart';
import 'package:ematch/App/model/eventModel.dart';
import 'package:ematch/App/model/groupModel.dart';
import 'package:ematch/App/model/userModel.dart';
import 'package:ematch/App/repository/groupRepository.dart';
import 'package:ematch/App/view/UserViews/eventPages/selectEventLocationPage.dart';
import 'package:ematch/App/view/UserViews/group/groupParticipantsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';

class GroupDetailsPage extends StatefulWidget {
  final GroupModel group;

  GroupDetailsPage({this.group});

  @override
  _GroupDetailsPageState createState() => _GroupDetailsPageState();
}

class _GroupDetailsPageState extends State<GroupDetailsPage> {
  EventController eventController = EventController();
  GroupController groupController = GroupController();
  Future<List<EventModel>> _getEventsByGroupID;
  List<EventModel> events;
  Future<List<UserModel>> _detailedGroupParticipants;
  List<UserModel> groupParticipants;

  @override
  void initState() {
    super.initState();
    _detailedGroupParticipants = widget.group.detailedGroupParticipants();
    _getEventsByGroupID = eventController.getEventsByGroupID(widget.group.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text("${widget.group.groupName} (${widget.group.activityName})"),
      ),
      body: FutureBuilder(
        future: Future.wait([_getEventsByGroupID, _detailedGroupParticipants]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            events = snapshot.data[0];
            groupParticipants = snapshot.data[1];
            groupParticipants.removeWhere((element) => element == null);
            return buildBody(context);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: buildBottomButtons(context),
      // ),
    );
  }

  dynamic buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildTopImageWidget(context),
          // Divider(),
          SizedBox(
            height: 20,
          ),
          buildDescription(),
          // Divider(),
          //  SizedBox(
          SizedBox(
            height: 20,
          ),
          buildNextEvents(),
          // Divider(),
          SizedBox(
            height: 20,
          ),
          buildGroupParticipantsList(context),
        ],
      ),
    );
  }

  Container buildGroupParticipantsList(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[900]),
      width: MediaQuery.of(context).size.width,
      height: 500,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Participantes (" +
                      widget.group.groupUsers.length.toString() +
                      ")",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.share),
                    tooltip: 'Increase volume by 10',
                    onPressed: () {
                      share(context, widget.group);
                    })
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: groupParticipants.length,
                itemBuilder: (context, index) {
                  UserModel user = groupParticipants[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.imageUrl),
                    ),
                    title: Row(
                      children: [
                        Text(user.userName),
                        Text(
                          widget.group.groupAdmins.contains(user.id)
                              ? " Admin"
                              : "",
                          style: TextStyle(
                            color: Colors.orangeAccent,
                            fontStyle: FontStyle.italic,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    // title: Card(
                    //   child: Container(child: Text(user.userName)),
                    // ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildNextEvents() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 1, left: 8, right: 8, top: 3),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Próximos Eventos",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                widget.group.groupAdmins.contains(myUserid)
                    ? ElevatedButton(
                        child: Text(
                          'Agendar Novo Evento',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SelectEventLocationPage()),
                          )
                        },
                      )
                    : SizedBox.shrink(),
              ],
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  border: Border.all(
                    width: 1,
                  ),
                ),
                child: ListView.builder(
                  // shrinkWrap: true,
                  itemCount: events == null ? 0 : events.length,
                  itemBuilder: (context, index) {
                    EventModel currEvent = events[index];
                    var eventName = currEvent.eventName;
                    var startDay = DateFormat("dd/MM")
                        .format(DateTime.parse(currEvent.startDate));
                    // ignore: unused_local_variable
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
                                              alignment: Alignment.centerLeft,
                                              child: Text("$eventName - 5 km")),
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
    );
  }

  bool descTextShowFlag = false;

  Padding buildDescription() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  "Descrição",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: buildButtonStatusUser(myUserid)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
          ),
          new Container(
            margin: EdgeInsets.all(8.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    widget.group.groupDescription != ""
                        ? widget.group.groupDescription
                        : "sem descrição...",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    maxLines: descTextShowFlag ? 8 : 2,
                    textAlign: TextAlign.start),
                InkWell(
                  onTap: () {
                    setState(() {
                      descTextShowFlag = !descTextShowFlag;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      descTextShowFlag
                          ? Text("Mostrar menos...",
                              style: TextStyle(color: Colors.blue))
                          : Text("Mostrar mais...",
                              style: TextStyle(color: Colors.blue))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton buildButtonStatusUser(String myUserId) {
    switch (widget.group.statusUserInGroup(myUserId)) {
      case StatusUserForGroup.admin:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
          ),
          child: Text(
            'Admin',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => {},
        );
        break;
      case StatusUserForGroup.follower:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.lightBlue,
          ),
          child: Text(
            'Seguindo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () async {
            try {
              GroupModel updateGroup =
                  await groupController.unfollowGroup(widget.group, myUserId);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => GroupDetailsPage(group: updateGroup)),
              );
            } catch (e) {}
          },
        );
        break;
      default:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
          ),
          child: Text(
            '+ Seguir',
            style: TextStyle(
              color: Colors.lightBlue,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () async {
            try {
              GroupModel updateGroup =
                  await groupController.followGroup(widget.group, myUserId);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => GroupDetailsPage(group: updateGroup)),
              );
            } catch (e) {}
          },
        );
    }
  }

  Stack buildTopImageWidget(BuildContext context) {
    return Stack(children: [
      Container(
        height: 170,
        width: MediaQuery.of(context).size.width,
        child: Image.network(
          widget.group.imageUrl,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),
      ),

      // Container(
      //   height: 150,
      //   width: MediaQuery.of(context).size.width,
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Align(
      //       alignment: Alignment.bottomCenter,
      //       child: Text(
      //         widget.group.groupName,
      //         style: TextStyle(color: Colors.white),
      //       ),
      //     ),
      //   ),
      // ),
    ]);
  }

  Column buildBottomButtons(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          // ignore: deprecated_member_use
          child: ElevatedButton(
            child: Text(
              'Agendar Novo Evento',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SelectEventLocationPage()),
              )
            },
          ),
        ),
      ],
    );
  }
}

void share(BuildContext context, GroupModel group) {
  final RenderBox box = context.findRenderObject();

  Share.share("${group.groupName} - ${group.groupDescription}",
      subject: group.groupDescription,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
}
