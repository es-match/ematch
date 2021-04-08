class ActivityModel {
  String id;
  String sportDescription;
  String sportName;
  String createDate;

  ActivityModel(
      {this.id, this.sportDescription, this.sportName, this.createDate});

  ActivityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sportDescription = json['sportDescription'];
    sportName = json['sportName'];
    createDate = json['createDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sportDescription'] = this.sportDescription;
    data['sportName'] = this.sportName;
    data['createDate'] = this.createDate;
    return data;
  }
}
