class ActivityModel {
  String id;
  String activityDescription;
  String activityName;
  String createDate;
  String imageUrl;

  ActivityModel(
      {this.id, this.activityDescription, this.activityName, this.createDate});

  ActivityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    activityDescription = json['activityDescription'];
    activityName = json['activityName'];
    createDate = json['createDate'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['activityDescription'] = this.activityDescription;
    data['activityName'] = this.activityName;
    data['createDate'] = this.createDate;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
