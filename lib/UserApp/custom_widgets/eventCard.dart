import 'package:ematch/UserApp/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventCard extends StatefulWidget {
  final EventModel event;

  const EventCard({Key key, this.event}) : super(key: key);

  @override
  _EventCardState createState() => _EventCardState(event);
}

class _EventCardState extends State<EventCard> {
  final EventModel event;

  _EventCardState(this.event);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(event.eventName)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Align(
                          alignment: Alignment.topRight,
                          child:
                              Container(child: Icon(Icons.check_box_rounded)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(Icons.calendar_today),
                              ),
                              TextSpan(
                                text: getEventDate(
                                    event.startDate, event.endDate),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  getEventDate(String startDate, String endDate) {
    DateTime sd = DateTime.parse(startDate);
    DateTime ed = DateTime.parse(endDate);
    String prefix = " ";
    if (DateTime.now().day == sd.day) {
      prefix = "Hoje, ";
    } else if (DateTime.now().day - sd.day == 1) {
      prefix = "Amanhã, ";
    } else {
      prefix = "Dia ${sd.day}, ";
    }
    print(DateFormat.Hm().format(sd));
    // print(ed);
    return '$prefix ${DateFormat.Hm().format(sd)} - ${DateFormat.Hm().format(ed)}';
  }
}
