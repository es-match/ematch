import 'package:ematch/App/model/eventModel.dart';
import 'package:ematch/App/repository/eventRepository.dart';

class EventController {
  EventRepository _repository = EventRepository();
  List<EventModel> events;

  int eventCount;

  Future<List<EventModel>> getEventsByGroupID(String groupID) {
    return _repository.getEventsByGroupID(groupID);
  }
}
