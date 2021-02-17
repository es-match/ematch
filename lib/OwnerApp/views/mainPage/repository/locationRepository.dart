import 'dart:convert';
import 'package:ematch/OwnerApp/views/mainPage/model/locationModel.dart';
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
}
