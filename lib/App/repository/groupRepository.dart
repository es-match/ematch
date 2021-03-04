import 'dart:convert';

import 'package:ematch/App/model/groupModel.dart';
import 'package:http/http.dart';

class GroupRepository {
  final url =
      "https://us-central1-esmatch-ce3c9.cloudfunctions.net/dbGroups/api/v1/groups/";

  Future<List<GroupModel>> getGroupsByUserID(String userID) async {
    String path = "$url/byUser/$userID";
        final response = await get(path);
    Iterable l = json.decode(response.body);
    List<GroupModel> locations = List<GroupModel>.from(
        l.map((model) => GroupModel.fromJson(model)));
    return locations;
  }
}
