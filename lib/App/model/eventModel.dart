import 'package:intl/intl.dart';

class EventModel {
  String id;
  String groupID;
  String eventName;
  String locationID;
  String startDate;
  String endDate;
  String createDate;
  List<String> confirmedUsers;
  String userID;
  String userName;
  String locationName;
  String address;
  String imageUrl;
  Geolocation geolocation;

  EventModel({
    this.id,
    this.groupID,
    this.eventName,
    this.locationID,
    this.startDate,
    this.endDate,
    this.confirmedUsers,
    this.createDate,
    this.userID,
    this.userName,
    this.locationName,
    this.address,
    this.imageUrl,
    this.geolocation,
  });

  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupID = json['groupID'];
    eventName = json['eventName'];
    locationID = json['locationID'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    confirmedUsers = json['confirmedUsers'].cast<String>();
    createDate = json['createDate'];
    locationName = json['locationName'];
    userID = json['userID'];
    userName = json['userName'];
    address = json['address'];
    imageUrl = json['imageUrl'];
    geolocation = json['geolocation'] != null
        ? new Geolocation.fromJson(json['geolocation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['groupID'] = this.groupID;
    data['eventName'] = this.eventName;
    data['locationID'] = this.locationID;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['confirmedUsers'] = this.confirmedUsers;
    data['createDate'] = this.createDate;
    data['locationName'] = this.locationName;
    data['userID'] = this.userID;
    data['userName'] = this.userName;
    data['address'] = this.address;
    data['imageUrl'] = this.imageUrl;
    if (this.geolocation != null) {
      data['geolocation'] = this.geolocation.toJson();
    }
    return data;
  }

  List<String> getAlocatedHoursList() {
    var startHour = int.parse(DateFormat("HH")
        .format(DateTime.parse(this.startDate).subtract(Duration(hours: 3))));
    var endHour = int.parse(DateFormat("HH")
        .format(DateTime.parse(this.endDate).subtract(Duration(hours: 3))));

    var diff = endHour - startHour;

    List<String> alocatedHoursList = [];
    for (var i = 0; i < diff; i++) {
      alocatedHoursList.add((startHour + i).toString().padLeft(2, '0'));
    }

    return alocatedHoursList;
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
