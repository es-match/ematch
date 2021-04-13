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

  Future<List<GroupModel>> getGroupsByName(String groupName) async {
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
    var _body = jsonEncode({
      "groupName": group.groupName,
      "groupDescription": group.groupDescription,
      "groupAdmins": group.userCreator,
      "groupPending": group.groupPending,
      "groupUser": group.userCreator,
      "imageUrl": group.imageUrl,
      "sportID": group.sportID,
      "sportRef": null,
      "createDate": DateTime.now().millisecondsSinceEpoch,
      "userCreator": group.userCreator,
    });

    // String path =
    //     "http://localhost:5001/esmatch-ce3c9/us-central1/dbGroups/api/v1/groups/";
    final response = await post(
      url,
      // path,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: _body,
    );

    print(response.statusCode);
  }
}
