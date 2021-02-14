import 'package:ematch/UserApp/models/event_model.dart';

class EventRepository {
  List<EventModel> getEvents() {
    List<EventModel> events = <EventModel>[];
    if (eventJson['events'] != null) {
      eventJson['events'].forEach((ev) {
        events.add(new EventModel.fromJson(ev));
      });
    }

    return events;
  }

  Map<String, dynamic> eventJson = {
    "events": [
      {
        "eventID": "1",
        "groupID": "1",
        "eventName": "FutBros de Domingo",
        "startDate": "2021-01-30 14:30:00",
        "endDate": "2021-01-30 16:00:00",
        "localID": "1",
        "localName": "Futebar"
      },
      {
        "eventID": "2",
        "groupID": "1",
        "eventName": "Bate bola jogo rapido",
        "startDate": "2021-02-01 16:15:00",
        "endDate": "2021-02-01 17:00:00",
        "localID": "2",
        "localName": "Cantinho Girassol"
      },
      {
        "eventID": "3",
        "groupID": "2",
        "eventName": "Fut das manas",
        "startDate": "2021-01-30 16:30:00",
        "endDate": "2021-01-30 18:00:00",
        "localID": "1",
        "localName": "Futebar"
      }
    ]
  };
}
