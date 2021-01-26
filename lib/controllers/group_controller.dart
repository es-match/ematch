import 'package:ematch/models/event_model.dart';

class GroupController {
  List<EventModel> events;

  GroupController() {
    this.events = getEvents();
  }

  List<EventModel> getEvents() {
    return [EventModel()]; //repository.get().map((e){return e.data}).ToList();
  }
}
