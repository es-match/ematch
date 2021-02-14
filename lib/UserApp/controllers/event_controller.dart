import 'package:ematch/UserApp/models/event_model.dart';
import 'package:ematch/UserApp/repository/event_repository.dart';
import 'package:flutter/cupertino.dart';

class EventController {
  EventRepository _repository = EventRepository();
  List<EventModel> events;

  int eventCount;

  TextEditingController _titulo;
  TextEditingController _descricao;

  EventController() {
    events = _repository.getEvents();
    eventCount = events.length;
  }
}
