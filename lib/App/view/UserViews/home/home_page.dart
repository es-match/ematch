import 'package:ematch/App/custom_widgets/eventList.dart';
import 'package:ematch/App/custom_widgets/groupList.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String name;
  final List<Widget> listBuilderItems = [EventList(), EventList()];

  HomePage({this.name});

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Ola, ' + name)),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 7,
            child: EventList(),
          ),
          Flexible(
            flex: 3,
            child: Container(width: _width, child: GroupList()),
          )
        ],
      ),
    );
  }
}
