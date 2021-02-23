class LocationModel {
  String id;
  String locationName;
  String zip;
  String city;
  String address;
  String number;
  String imageUrl;
  String geolocation;
  String createDate;

  LocationModel(
      {this.id,
      this.locationName,
      this.zip,
      this.city,
      this.address,
      this.number,
      this.imageUrl,
      this.geolocation,
      this.createDate});

  LocationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    locationName = json['locationName'];
    zip = json['zip'];
    city = json['city'];
    address = json['address'];
    number = json['number'];
    imageUrl = json['imageUrl'];
    geolocation = json['geolocation'];
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
    data['geolocation'] = this.geolocation;
    data['createDate'] = this.createDate;
    return data;
  }
}
