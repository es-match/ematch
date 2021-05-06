import 'package:ematch/App/controller/sign_in.dart';
// import 'package:ematch/App/custom_widgets/background_painter.dart';
import 'package:ematch/App/model/groupModel.dart';
import 'package:flutter/material.dart';

class GroupCard extends StatefulWidget {
  final GroupModel group;

  GroupCard({Key key, this.group}) : super(key: key);

  @override
  _GroupCardState createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Color.fromRGBO(72, 72, 72, 0.45),
        elevation: 5,
        shadowColor: Colors.grey[800],
        margin: EdgeInsets.all(3),
        child: Stack(
          children: [
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [
                    0.1,
                    0.4,
                    0.6,
                    0.9,
                  ],
                  colors: [
                    Colors.white,
                    Colors.deepOrangeAccent[100],
                    Colors.deepOrangeAccent[200],
                    Colors.deepOrangeAccent[400],
                  ],
                ),
                image: DecorationImage(
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.30), BlendMode.dstATop),
                  image: NetworkImage(
                    widget.group.imageUrl,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 65.0),
              child: Container(
                height: 35,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: Stack(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.group.groupName,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )),
                  ),
                  // Icon(
                  //   Icons.login,
                  //   color: Colors.white,
                  //   size: 20.0,
                  //   semanticLabel: 'Crie uma nova conta',
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "" + widget.group.activityName + "",
                        style: TextStyle(
                          color: Colors.indigo[900],
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ]),
              ),
            ),
            Align(
                alignment: Alignment.topRight,
                child: buildChipStatusUser(myUserid)

                // Container(
                //   height: 30,
                //   width: MediaQuery.of(context).size.width / 3,
                //   color: Colors.blue,
                // ),
                ),
          ],
        ),
      ),
    );
  }

  Chip buildChipStatusUser(String myUserId) {
    switch (widget.group.statusUserInGroup(myUserId)) {
      case StatusUserForGroup.admin:
        return Chip(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.all(0),
          avatar: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Icon(
              Icons.admin_panel_settings,
              color: Colors.black,
              size: 23.0,
            ),
          ),
          label: Text("Admin",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
        );
        break;
      case StatusUserForGroup.follower:
        return Chip(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.all(0),
          avatar: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Icon(
              Icons.visibility,
              color: Colors.black,
              size: 23.0,
            ),
          ),
          label: Text("Seguindo",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
        );
        break;
      default:
        return Chip(
          backgroundColor: Colors.yellow,
          padding: const EdgeInsets.all(0),
          avatar: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Icon(
              Icons.search,
              color: Colors.black,
              size: 23.0,
            ),
          ),
          label: Text("Saber Mais",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
        );
    }
  }
}
