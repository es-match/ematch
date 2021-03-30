import 'package:ematch/App/model/eventModel.dart';
import 'package:ematch/App/repository/eventRepository.dart';

class EventController {
  EventRepository _repository = EventRepository();
  List<EventModel> events;

  int eventCount;

  Future<List<EventModel>> getEventsByUserID(String userID) async {
    List<EventModel> auxEvents = await _repository.getEvents();
    for (var ev in auxEvents) {
      if (!ev.confirmedUsers.contains(userID)) {
        auxEvents.remove(ev);
      }
    }
    return auxEvents;
  }

  Future<List<EventModel>> getEventsByGroupID(String groupID) {
    return _repository.getEventsByGroupID(groupID);
  }
}
