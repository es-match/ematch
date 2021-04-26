class LocationModel {
  String id;
  String locationName;
  String zip;
  String city;
  String address;
  String number;
  String imageUrl;
  Geolocation geolocation;
  Null createDate;
  String avaiableDays;
  String avaiableHours;
  String hourValue;

  LocationModel(
      {this.id,
      this.locationName,
      this.zip,
      this.city,
      this.address,
      this.number,
      this.imageUrl,
      this.geolocation,
      this.createDate,
      this.avaiableDays,
      this.avaiableHours,
      this.hourValue});

  LocationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    locationName = json['locationName'];
    zip = json['zip'];
    city = json['city'];
    address = json['address'];
    number = json['number'];
    imageUrl = json['imageUrl'];
    geolocation = json['geolocation'] != null
        ? new Geolocation.fromJson(json['geolocation'])
        : null;
    avaiableDays = json['avaiableDays'];
    avaiableHours = json['avaiableHours'];
    hourValue = json['hourValue'];

    createDate = json['createDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['locationName'] = this.locationName;
    data['zip'] = this.zip;
    data['city'] = this.city;
    data['address'] = this.address;
    data['number'] = this.number;
    data['imageUrl'] = this.imageUrl;
    if (this.geolocation != null) {
      data['geolocation'] = this.geolocation.toJson();
    }
    data['createDate'] = this.createDate;
    data['avaiableDays'] = this.avaiableDays;
    data['avaiableHours'] = this.avaiableHours;
    data['hourValue'] = this.hourValue;
    return data;
  }
}

class Geolocation {
  double dLatitude;
  double dLongitude;

  Geolocation({this.dLatitude, this.dLongitude});

  Geolocation.fromJson(Map<String, dynamic> json) {
    dLatitude = json['_latitude'];
    dLongitude = json['_longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_latitude'] = this.dLatitude;
    data['_longitude'] = this.dLongitude;
    return data;
  }
}
