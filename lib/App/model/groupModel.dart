import 'package:ematch/App/model/userModel.dart';
import 'package:ematch/App/repository/userRepository.dart';

enum StatusUserForGroup {
  none,
  admin,
  follower,
}

class GroupModel {
  String id;
  String groupName;
  String groupDescription;
  List<String> groupAdmins;
  List<String> groupPending;
  List<String> groupUsers;
  String activityID;
  String activityName;
  String imageUrl;
  String userCreator;

  GroupModel(
      {this.id,
      this.groupName,
      this.groupAdmins,
      this.groupPending,
      this.groupUsers,
      this.imageUrl,
      this.activityID,
      this.activityName,
      this.userCreator});

  GroupModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupName = json['groupName'];
    groupDescription = json['groupDescription'];
    groupAdmins = json['groupAdmins'].cast<String>();
    groupPending = json['groupPending'].cast<String>();
    groupUsers = json['groupUsers'].cast<String>();
    activityID = json['activityID'];
    activityName = json['activityName'];
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
    data['groupUsers'] = this.groupUsers;
    data['activityID'] = this.activityID;
    data['activityName'] = this.activityName;
    data['imageUrl'] = this.imageUrl;
    data['userCreator'] = this.userCreator;
    return data;
  }

  StatusUserForGroup statusUserInGroup(String userId) {
    if (this.groupAdmins.contains(userId)) {
      return StatusUserForGroup.admin;
    }
    if (this.groupUsers.contains(userId)) {
      return StatusUserForGroup.follower;
    }
    return StatusUserForGroup.none;
  }

  Future<List<UserModel>> detailedGroupParticipants() async {
    UserRepository rep = UserRepository();
    return rep.getUserByList(this.groupUsers);
  }
}
