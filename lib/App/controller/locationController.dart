import 'package:ematch/App/model/locationModel.dart';
import 'package:ematch/App/repository/locationRepository.dart';
import 'package:flutter/cupertino.dart';

class LocationController {
  final TextEditingController name;
  final TextEditingController cep;
  final TextEditingController city;
  final TextEditingController address;
  final TextEditingController number;

  LocationController(
      {this.name, this.cep, this.city, this.address, this.number});

  LocationRepository repository = LocationRepository();

  insertLocation() {
    repository.insertLocation(
        userID: "1",
        name: name.text,
        cep: this.cep.text,
        city: this.city.text,
        address: this.address.text,
        number: this.number.text);
  }

  editLocation(locationId) {
    repository.editLocation(
        locationID: locationId,
        // userID: userID,
        name: name.text,
        cep: this.cep.text,
        city: this.city.text,
        address: this.address.text,
        number: this.number.text);
  }

  Future<List<LocationModel>> getLocations() {
    return repository.getLocations();
  }

  void editAvaiability(
      String id, Map<int, bool> hoursList, Map<String, bool> daysList) {
    String _daysList = "";
    String _hoursList = "";

    daysList.forEach((key, value) {
      if (value)
        _daysList = _daysList.isNotEmpty
            ? "$_daysList, ${key.toString()}"
            : key.toString();
    });

    hoursList.forEach((key, value) {
      if (value)
        _hoursList = _hoursList.isNotEmpty
            ? "$_hoursList, ${key.toString()}"
            : key.toString();
    });
    repository.editAvaiability(id, _hoursList, _daysList);
  }
}
