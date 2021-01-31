class GroupModel {
  String userID;
  String groupID;
  String groupName;
  String sportID;
  String sportDesc;
  String description;
  String groupPicture;

  GroupModel(
      {this.userID,
      this.groupID,
      this.groupName,
      this.sportID,
      this.sportDesc,
      this.description,
      this.groupPicture});

  GroupModel.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    groupID = json['groupID'];
    groupName = json['groupName'];
    sportID = json['sportID'];
    sportDesc = json['sportDesc'];
    description = json['description'];
    groupPicture = json['groupPicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['groupID'] = this.groupID;
    data['groupName'] = this.groupName;
    data['sportID'] = this.sportID;
    data['sportDesc'] = this.sportDesc;
    data['description'] = this.description;
    data['groupPicture'] = this.groupPicture;
    return data;
  }
}

