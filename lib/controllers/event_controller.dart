import 'package:ematch/models/event_model.dart';
import 'package:ematch/repository/event_repository.dart';

class EventController {
  EventRepository _repository = EventRepository();
  List<EventModel> events;
  int eventCount;
  EventController() {
    events = _repository.getEvents();
    eventCount = events.length;
  }
}
