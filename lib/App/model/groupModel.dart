class GroupModel {
  String id;
  String groupName;
  String groupDescription;
  List<String> groupAdmins;
  List<String> groupPending;
  List<String> groupUser;
  String sportID;
  String imageUrl;
  String userCreator;

  GroupModel(
      {this.id,
      this.groupName,
      this.groupAdmins,
      this.groupPending,
      this.groupUser,
      this.imageUrl,
      this.userCreator});

  GroupModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupName = json['groupName'];
    groupDescription = json['groupDescription'];
    groupAdmins = json['groupAdmins'].cast<String>();
    groupPending = json['groupPending'].cast<String>();
    groupUser = json['groupUser'].cast<String>();
    sportID = json['sportID'];
    imageUrl = json['imageUrl'];
    userCreator = json['userCreator'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['groupName'] = this.groupName;
    data['groupDescription'] = this.groupDescription;
    data['groupAdmins'] = this.groupAdmins;
    data['groupPending'] = this.groupPending;
    data['groupUser'] = this.groupUser;
    data['sportID'] = this.sportID;
    data['imageUrl'] = this.imageUrl;
    data['userCreator'] = this.userCreator;
    return data;
  }
}
