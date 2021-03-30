import 'package:ematch/App/model/eventModel.dart';
import 'package:ematch/App/repository/eventRepository.dart';

class EventController {
  EventRepository _repository = EventRepository();
  List<EventModel> events;

  int eventCount;

  Future<List<EventModel>> getEventsByUserID(String userID) async {
    List<EventModel> listEvents = await _repository.getEvents();
    List<EventModel> finalEvents = [];
    for (var ev in listEvents) {
      if (ev.confirmedUsers.contains(userID)) {
        finalEvents.add(ev);
      }
    }
    return finalEvents;
  }

  Future<List<EventModel>> getEventsByGroupID(String groupID) {
    return _repository.getEventsByGroupID(groupID);
  }
}
