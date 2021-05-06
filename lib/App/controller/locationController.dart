import 'package:ematch/App/controller/sign_in.dart';
import 'package:ematch/App/model/eventModel.dart';
import 'package:ematch/App/model/locationModel.dart';
import 'package:ematch/App/repository/eventRepository.dart';
import 'package:ematch/App/repository/locationRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart';

class LocationController {
  final TextEditingController name;
  final TextEditingController cep;
  final TextEditingController city;
  final TextEditingController address;
  final TextEditingController number;

  LocationController(
      {this.name, this.cep, this.city, this.address, this.number});

  LocationRepository locationRepository = LocationRepository();
  EventRepository eventRepository = EventRepository();

  Future<LocationModel> insertLocation(
      LocationModel location, Coordinates coordinates) {
    LocationModel model = location;

    return locationRepository.insertLocation(model, coordinates);
  }

  editLocation(LocationModel model) {
    locationRepository.editLocation(model);
  }

  Future<List<LocationModel>> getLocations() {
    return locationRepository.getLocations();
  }

  void editAvaiability(String id, Map<int, bool> hoursList,
      Map<String, bool> daysList, String hourValue) {
    String _daysList = "";
    String _hoursList = "";

    daysList.forEach((key, value) {
      if (value)
        _daysList = _daysList.isNotEmpty
            ? "$_daysList,${key.toString()}"
            : key.toString();
    });

    hoursList.forEach((key, value) {
      if (value)
        _hoursList = _hoursList.isNotEmpty
            ? "$_hoursList,${key.toString()}"
            : key.toString();
    });
    locationRepository.editAvaiability(id, _hoursList, _daysList, hourValue);
  }

  Future<Map<DateTime, List<EventModel>>> getLocationEvents(
      String locationID) async {
    List<EventModel> events =
        await eventRepository.getEventsByLocation(locationID);

    Map<DateTime, List<EventModel>> futureEvents = Map.fromIterable(events,
        key: (k) {
          var evDay = DateTime.parse(k.startDate);
          evDay = DateTime(evDay.year, evDay.month, evDay.day);
          return evDay;
        },
        value: (v) => []);

    for (EventModel ev in events) {
      var evDay = DateTime.parse(ev.startDate);
      evDay = DateTime(evDay.year, evDay.month, evDay.day);
      // var endDay = DateFormat("dd/MM").format(DateTime.parse(ev.endDate));
      // var startTime = DateFormat("HH:mm").format(DateTime.parse(ev.startDate));
      // var endTime = DateFormat("HH:mm").format(DateTime.parse(ev.endDate));

      List list = futureEvents[evDay];
      // if (list.isEmpty)
      //   list = [ev];
      // else
      list.add(ev);
      futureEvents[evDay] = list;
    }

    return futureEvents;
  }
}
