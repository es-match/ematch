class GroupModel {
  String id;
  String groupName;
  List<String> groupAdmins;
  List<String> groupPending;
  List<String> groupUser;
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
    groupAdmins = json['groupAdmins'].cast<String>();
    groupPending = json['groupPending'].cast<String>();
    groupUser = json['groupUser'].cast<String>();
    imageUrl = json['imageUrl'];
    userCreator = json['userCreator'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['groupName'] = this.groupName;
    data['groupAdmins'] = this.groupAdmins;
    data['groupPending'] = this.groupPending;
    data['groupUser'] = this.groupUser;
    data['imageUrl'] = this.imageUrl;
    data['userCreator'] = this.userCreator;
    return data;
  }
}
