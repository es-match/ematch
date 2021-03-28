import 'dart:convert';

import 'package:ematch/App/model/eventModel.dart';
import 'package:http/http.dart';

class EventRepository {
  final String url =
      "https://us-central1-esmatch-ce3c9.cloudfunctions.net/dbEvents/api/v1/events";

  // List<EventModel> getEvents() {

  //   List<EventModel> events = <EventModel>[];
  //   if (eventJson['events'] != null) {
  //     eventJson['events'].forEach((ev) {
  //       events.add(new EventModel.fromJson(ev));
  //     });
  //   }

  //   return events;
  // }

  Future<List<EventModel>> getEventsByGroupID(String groupID) async {
    String path = "$url/byGroup/$groupID";
    final response = await get(path);
    Iterable l = json.decode(response.body);
    List<EventModel> events =
        List<EventModel>.from(l.map((model) => EventModel.fromJson(model)));
    return events;
  }

  // Map<String, dynamic> eventJson = {
  //   "events": [
  //     {
  //       "eventID": "1",
  //       "groupID": "1",
  //       "eventName": "FutBros de Domingo",
  //       "startDate": "2021-01-30 14:30:00",
  //       "endDate": "2021-01-30 16:00:00",
  //       "localID": "1",
  //       "localName": "Futebar"
  //     },
  //     {
  //       "eventID": "2",
  //       "groupID": "1",
  //       "eventName": "Bate bola jogo rapido",
  //       "startDate": "2021-02-01 16:15:00",
  //       "endDate": "2021-02-01 17:00:00",
  //       "localID": "2",
  //       "localName": "Cantinho Girassol"
  //     },
  //     {
  //       "eventID": "3",
  //       "groupID": "2",
  //       "eventName": "Fut das manas",
  //       "startDate": "2021-01-30 16:30:00",
  //       "endDate": "2021-01-30 18:00:00",
  //       "localID": "1",
  //       "localName": "Futebar"
  //     }
  //   ]
  // };
}
