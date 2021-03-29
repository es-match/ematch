import 'package:ematch/App/controller/eventController.dart';
import 'package:ematch/App/custom_widgets/eventList.dart';
import 'package:ematch/App/custom_widgets/groupList.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String name;

  HomePage({this.name});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> listBuilderItems = [EventList(), EventList()];

  EventController _controller = EventController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Ola, ' + widget.name)),
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
