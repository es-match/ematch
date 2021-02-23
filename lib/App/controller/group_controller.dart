import 'package:ematch/App/model/eventModel.dart';

class GroupController {
  List<EventModel> events;

  GroupController() {
    this.events = getEvents();
  }

  List<EventModel> getEvents() {
    return [EventModel()]; //repository.get().map((e){return e.data}).ToList();
  }
}
