import 'dart:convert';
import 'package:ematch/App/model/locationModel.dart';
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

  void insertLocation(
      {String userID,
      String name,
      String cep,
      String city,
      String address,
      String number,
      String imageUrl = "/imageurl",
      String geolocation = "99999"}) async {
    var _body = jsonEncode(
      <String, String>{
        "userID": userID,
        "name": name,
        "zip": cep,
        "city": city,
        "address": address,
        "number": number,
        "imageUrl": imageUrl,
        "geolocation": geolocation
      },
    );
    final response = await post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: _body,
    );

    print(response.statusCode);
  }

  void editLocation(
      {String locationID,
      String userID,
      String name,
      String cep,
      String city,
      String address,
      String number,
      String imageUrl = "/imageurl",
      String geolocation = "99999"}) async {
    var _body = jsonEncode(
      <String, String>{
        "userID": userID,
        "name": name,
        "zip": cep,
        "city": city,
        "address": address,
        "number": number,
        "imageUrl": imageUrl,
        "geolocation": geolocation
      },
    );
    final response = await patch(
      url + "/$locationID",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: _body,
    );
    print(response.statusCode);
  }

  void editAvaiability(String id, String hoursList, String daysList) async {
    var _body = jsonEncode(
      <String, String>{
        "avaiableDays": daysList,
        "avaiableHours": hoursList,
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
