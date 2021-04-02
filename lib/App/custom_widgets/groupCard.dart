import 'package:ematch/App/model/groupModel.dart';
import 'package:flutter/material.dart';

class GroupCard extends StatefulWidget {
  final GroupModel group;
  final String sportName;

  GroupCard({Key key, this.group, this.sportName = ""}) : super(key: key);

  @override
  _GroupCardState createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              widget.group.imageUrl,
              fit: BoxFit.none,
            ),
          ),
          Container(
            height: 30,
            width: MediaQuery.of(context).size.width,
            color: Color.fromRGBO(5, 5, 5, 0.65),
          ),
          Container(
            height: 100,
            child: Stack(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.group.groupName,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
              ),
              // Icon(
              //   Icons.login,
              //   color: Colors.white,
              //   size: 20.0,
              //   semanticLabel: 'Crie uma nova conta',
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    widget.sportName,
                    style: TextStyle(
                        color: Colors.white, fontStyle: FontStyle.italic),
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
