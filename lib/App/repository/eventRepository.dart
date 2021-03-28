import 'dart:convert';

import 'package:ematch/App/model/eventModel.dart';
import 'package:http/http.dart';

class EventRepository {
  final String url =
      "https://us-central1-esmatch-ce3c9.cloudfunctions.net/dbEvents/api/v1/events";

  Future<List<EventModel>> getEventsByGroupID(String groupID) async {
    String path = "$url/byGroup/$groupID";
    final response = await get(path);
    if (response.body.toUpperCase().contains("NOT FOUND")) {
      return null;
    } else {
      Iterable l = json.decode(response.body);
      List<EventModel> events =
          List<EventModel>.from(l.map((model) => EventModel.fromJson(model)));
      return events;
    }
  }
}
