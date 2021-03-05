import 'package:ematch/App/model/groupModel.dart';
import 'package:flutter/material.dart';

class GroupCard extends StatefulWidget {
  final GroupModel group;

  const GroupCard({Key key, this.group}) : super(key: key);

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
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(widget.group.groupName)),
            ),
          )
        ],
      ),
    );
  }
}
