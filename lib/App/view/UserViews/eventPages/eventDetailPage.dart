import 'package:ematch/App/custom_widgets/eventCard.dart';
import 'package:ematch/App/model/eventModel.dart';
import 'package:flutter/material.dart';

class EventDetailPage extends StatefulWidget {
  final EventModel model;

  const EventDetailPage({Key key, this.model}) : super(key: key);

  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do Evento"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [EventCard(event: widget.model)],
        ),
      ),
    );
  }
}
