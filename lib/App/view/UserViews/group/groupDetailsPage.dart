import 'package:ematch/App/model/groupModel.dart';
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
      body: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
            widget.group.imageUrl,
            fit: BoxFit.none,
          ),
        ),
      ),
    );
  }
}
