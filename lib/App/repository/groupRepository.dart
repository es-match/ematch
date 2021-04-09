import 'dart:convert';

import 'package:ematch/App/model/groupModel.dart';
import 'package:http/http.dart';

class GroupRepository {
  final url =
      "https://us-central1-esmatch-ce3c9.cloudfunctions.net/dbGroups/api/v1/groups";

  Future<List<GroupModel>> getGroupsByUserID(String userID) async {
    String path = "$url/byUser/$userID";
    final response = await get(path);
    Iterable l = json.decode(response.body);
    List<GroupModel> groups =
        List<GroupModel>.from(l.map((model) => GroupModel.fromJson(model)));
    return groups;
  }

  Future<List<GroupModel>> getGroups() async {
    String path = "$url";
    final response = await get(path);
    Iterable l = json.decode(response.body);
    List<GroupModel> groups =
        List<GroupModel>.from(l.map((model) => GroupModel.fromJson(model)));
    return groups;
  }

  Future<List<GroupModel>> getGroupsByNane(String groupName) async {
    String path = "$url/byName/$groupName";
    final response = await get(path);
    List<GroupModel> groups = <GroupModel>[];
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      groups =
          List<GroupModel>.from(l.map((model) => GroupModel.fromJson(model)));
    }
    return groups;
  }

  void insertGroup(GroupModel group) async {
       var _body = jsonEncode(group.toJson());
      <String, dynamic>{
         "groupName": group.groupName,
    "groupAdmins": group.groupAdmins,
    "groupPending": [],
    "groupUser": [group.groupUser],
    "imageUrl": group.imageUrl,
    "sportID": group.sportID,
    "sportRef": null,
    "createDate": actualDate,
    "userCreator": request.body.userCreator,
      },
    );
    final response = await post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: _body,
    );

    print(response.statusCode);
  }



}
