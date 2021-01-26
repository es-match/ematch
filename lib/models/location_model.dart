class LocationModel {
  String locationID;
  String locationName;
  String locationAdress;
  String locationCity;
  String locationState;

  LocationModel(
      {this.locationID,
      this.locationName,
      this.locationAdress,
      this.locationCity,
      this.locationState});

  LocationModel.fromJson(Map<String, dynamic> json) {
    locationID = json['locationID'];
    locationName = json['locationName'];
    locationAdress = json['locationAdress'];
    locationCity = json['locationCity'];
    locationState = json['locationState'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationID'] = this.locationID;
    data['locationName'] = this.locationName;
    data['locationAdress'] = this.locationAdress;
    data['locationCity'] = this.locationCity;
    data['locationState'] = this.locationState;
    return data;
  }
}
