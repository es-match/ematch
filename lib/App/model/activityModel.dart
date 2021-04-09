class ActivityModel {
  String id;
  String sportDescription;
  String sportName;
  String createDate;
  String imageUrl;

  ActivityModel(
      {this.id, this.sportDescription, this.sportName, this.createDate});

  ActivityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sportDescription = json['sportDescription'];
    sportName = json['sportName'];
    createDate = json['createDate'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sportDescription'] = this.sportDescription;
    data['sportName'] = this.sportName;
    data['createDate'] = this.createDate;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
