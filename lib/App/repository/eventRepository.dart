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

  Future<List<EventModel>> getEvents() async {
    String path = url;
    final response = await get(path);
    Iterable l = json.decode(response.body);
    List<EventModel> events =
        List<EventModel>.from(l.map((model) => EventModel.fromJson(model)));
    return events;
  }

  Future<List<EventModel>> getEventsByLocation(String locationID) async {
    String path = "$url/byLocation/$locationID";
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

  getEventsByUserID(String userID) async {
    String path = "$url/byUserFollow/$userID";
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

  Future<EventModel> insertEvent(EventModel event) async {
    var _body = jsonEncode({
    "userID": event.userID,
    "eventName": event.eventName,
    "locationID": event.locationID,
    "groupID": event.groupID,
    "startDate": event.startDate,
    "endDate": event.endDate,
  });


   final response = await post(
      url,
      // path,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: _body,
    );

    EventModel newEvent;

    print(response.statusCode);
    Map<String, dynamic> l;
    if (response.statusCode == 200) {
      l = json.decode(response.body);
      newEvent = EventModel.fromJson(l);
    }
    return newEvent;
  }  
}
