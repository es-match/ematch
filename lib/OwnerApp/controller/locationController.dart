import 'package:ematch/OwnerApp/repository/locationRepository.dart';
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
}
