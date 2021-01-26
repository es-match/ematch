class EventModel {
  String eventID;
  String groupID;
  String eventName;
  String startDate;
  String enddate;
  String localID;
  String localName;

  EventModel(
      {this.eventID,
      this.groupID,
      this.eventName,
      this.startDate,
      this.enddate,
      this.localID,
      this.localName});

  EventModel.fromJson(Map<String, dynamic> json) {
    eventID = json['eventID'];
    groupID = json['groupID'];
    eventName = json['eventName'];
    startDate = json['startDate'];
    enddate = json['enddate'];
    localID = json['localID'];
    localName = json['localName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventID'] = this.eventID;
    data['groupID'] = this.groupID;
    data['eventName'] = this.eventName;
    data['startDate'] = this.startDate;
    data['enddate'] = this.enddate;
    data['localID'] = this.localID;
    data['localName'] = this.localName;
    return data;
  }
}
