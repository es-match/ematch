import 'package:ematch/controllers/event_controller.dart';
import 'package:ematch/custom_widgets/eventCard.dart';
import 'package:flutter/material.dart';

class EventList extends StatelessWidget {
  EventList({
    Key key,
  }) : super(key: key);

  final EventController _controller = EventController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // shrinkWrap: true,
      itemCount: _controller.eventCount,
      itemBuilder: (context, index) => ListTile(
        title: EventCard(event: _controller.events[index]),
      ),
    );
  }
}
