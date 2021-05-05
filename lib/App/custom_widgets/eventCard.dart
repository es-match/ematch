import 'package:ematch/App/model/eventModel.dart';
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
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    event.imageUrl,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      color: Colors.black54,
                      height: 32,
                      width: 500,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: event.activityName,
                                style: TextStyle(
                                  color: Colors.yellowAccent,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(text: "   "),
                              WidgetSpan(
                                child: Icon(
                                  Icons.calendar_today,
                                  size: 16,
                                ),
                              ),
                              TextSpan(text: "   "),
                              TextSpan(
                                text: getEventDate(
                                    event.startDate, event.endDate),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Colors.black54,
                      height: 25,
                      width: 500,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Grupo: ",
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: event.groupName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Align(
              //           alignment: Alignment.topLeft,
              //           child: Text(event.eventName)),
              //       Column(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Align(
              //             alignment: Alignment.topLeft,
              //             child: Container(
              //               color: Colors.blue,
              //               child: Text.rich(
              //                 TextSpan(
              //                   children: [
              //                     TextSpan(
              //                       text: event.activityName,
              //                     ),
              //                     WidgetSpan(
              //                       child: Icon(Icons.calendar_today),
              //                     ),
              //                     TextSpan(
              //                       text: getEventDate(
              //                           event.startDate, event.endDate),
              //                     )
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           ),
              //           Container(
              //             child: Align(
              //               alignment: Alignment.topRight,
              //               child:
              //                   Container(child: Icon(Icons.check_box_rounded)),
              //             ),
              //           ),
              //         ],
              //       )
              //     ],
              //   ),
              // ),
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
    return '$prefix das ${DateFormat.Hm().format(sd)} - ${DateFormat.Hm().format(ed)}';
  }
}
