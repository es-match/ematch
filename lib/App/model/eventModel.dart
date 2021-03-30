class EventModel {
  String id;
  String groupID;
  String eventName;
  String locationID;
  String startDate;
  String endDate;
  String createDate;
  List<String> confirmedUsers;

  EventModel(
      {this.id,
      this.groupID,
      this.eventName,
      this.locationID,
      this.startDate,
      this.endDate,
      this.confirmedUsers,
      this.createDate});

  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupID = json['groupID'];
    eventName = json['eventName'];
    locationID = json['locationID'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    confirmedUsers = json['confirmedUsers'].cast<String>();
    createDate = json['createDate'];
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
    return data;
  }
}
