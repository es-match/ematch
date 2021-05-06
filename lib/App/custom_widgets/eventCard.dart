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
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [
                    0.1,
                    0.4,
                    0.6,
                    0.9,
                  ],
                  colors: [
                    Colors.deepOrange[400],
                    Colors.deepOrange[600],
                    Colors.deepOrange[700],
                    Colors.deepOrange[900],
                  ],
                ),
                image: DecorationImage(
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.10), BlendMode.dstATop),
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
                      color: Colors.transparent,
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
                                  color: Colors.indigo[900],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              TextSpan(text: "   "),
                              WidgetSpan(
                                child: Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
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
                    alignment: Alignment.centerLeft,
                    child: Container(
                      color: Colors.transparent,
                      height: 32,
                      width: 500,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Grupo:",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              TextSpan(text: "   "),
                              TextSpan(
                                text: event.groupName,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
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
                      color: Colors.transparent,
                      height: 30,
                      width: 500,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Local: ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              TextSpan(
                                text: event.locationName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
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
