import 'package:ematch/App/controller/eventController.dart';
import 'package:ematch/App/controller/sign_in.dart';
import 'package:ematch/App/custom_widgets/eventCard.dart';
import 'package:ematch/App/custom_widgets/eventList.dart';
import 'package:ematch/App/custom_widgets/groupList.dart';
import 'package:ematch/App/model/eventModel.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String name;
  final String userID;
  final changeIndexFunction;

  HomePage({this.name, this.userID, this.changeIndexFunction});

  @override
  _HomePageState createState() => _HomePageState();
}

List<EventModel> _eventList = [];

class _HomePageState extends State<HomePage> {
  final List<Widget> listBuilderItems = [EventList(), EventList()];
  Future<List<EventModel>> future;
  EventController _controller = EventController();

  @override
  void initState() {
    super.initState();
    future = _controller.getEventsByUserID(myUserid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: Text('Ola, ' + widget.name)),
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            _eventList = snapshot.data;
            return buildBody();
          } else
            return Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: buildBottomButtons(context),
    );
  }

  dynamic buildBody() {
    if (_eventList.length == 0 || _eventList == null) {
      return Align(
        alignment: Alignment.topCenter,
        child: Text(
          "Nenhum evento futuro",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              // shrinkWrap: true,
              itemCount: _eventList.length,
              itemBuilder: (context, index) => ListTile(
                title: EventCard(event: _eventList[index]),
              ),
            ),
          ),
        ],
      );
    }
  }

  Row buildBottomButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
                child: Text('Buscar Grupos'),
                onPressed: () {
                  widget.changeIndexFunction(1);
                }),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              child: Text('Meus Grupos'),
              onPressed: () {
                // controller.setScreenIndex(3);
                setState(() {
                  widget.changeIndexFunction(2);
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
