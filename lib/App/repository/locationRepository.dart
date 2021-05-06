import 'dart:convert';
import 'package:ematch/App/controller/sign_in.dart';
import 'package:ematch/App/model/locationModel.dart';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart';

class LocationRepository {
  final url =
      "https://us-central1-esmatch-ce3c9.cloudfunctions.net/dbLocations/api/v1/locations/";

  Future<List<LocationModel>> getLocations() async {
    final response = await get(url);
    Iterable l = json.decode(response.body);
    List<LocationModel> locations = List<LocationModel>.from(
        l.map((model) => LocationModel.fromJson(model)));
    return locations;
  }

  Future<LocationModel> insertLocation(
      LocationModel location, Coordinates coord) async {
    var _body = jsonEncode(
      <String, dynamic>{
        "address": location.address,
        "avaiableDays": location.avaiableDays,
        "avaiableHours": location.avaiableHours,
        "city": location.city,
        "latitude": coord.latitude,
        "longitude": coord.longitude,
        "hourValue": location.hourValue,
        "imageUrl": location.imageUrl,
        "locationName": location.locationName,
        "number": location.number,
        "userID": location.userID,
        "zip": location.zip,
      },
    );
    final response = await post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: _body,
    );

    // print(response.statusCode);

    LocationModel newLocation;

    print(response.statusCode);
    Map<String, dynamic> l;
    if (response.statusCode == 200) {
      l = json.decode(response.body);
      newLocation = LocationModel.fromJson(l);
    }
    return newLocation;
  }

  void editLocation(LocationModel location) async {
    var _body = jsonEncode(
      <String, dynamic>{
        "address": location.address,
        "city": location.city,        
        "locationName": location.locationName,
        "number": location.number,
        // "userID": location.userID,
        "zip": location.zip,
      },
    );

    final response = await patch(
      url + "${location.id}",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: _body,
    );
    print(response.statusCode);
  }

  void editAvaiability(
      String id, String hoursList, String daysList, String hourValue) async {
    var _body = jsonEncode(
      <String, String>{
        "avaiableDays": daysList,
        "avaiableHours": hoursList,
        "hourValue": hourValue,
      },
    );
    final response = await patch(
      url + "avaiability/$id",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: _body,
    );
    print(response.statusCode);
  }
}
