import 'package:ematch/App/model/eventModel.dart';
import 'package:ematch/App/repository/eventRepository.dart';

class EventController {
  EventRepository _repository = EventRepository();
  List<EventModel> events;

  int eventCount;

  // TextEditingController _titulo;
  // TextEditingController _descricao;

  EventController() {
    events = _repository.getEvents();
    eventCount = events.length;
  }
}
