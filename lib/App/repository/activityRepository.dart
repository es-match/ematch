import 'dart:convert';

import 'package:ematch/App/model/activityModel.dart';
import 'package:http/http.dart';

class ActivityRepository {
  final String url =
      "https://us-central1-esmatch-ce3c9.cloudfunctions.net/dbEvents/api/v1/activities";

  Future<List<ActivityModel>> getActivities() async {
    String path = url;
    final response = await get(path);
    if (response.body.toUpperCase().contains("NOT FOUND")) {
      return null;
    } else {
      Iterable l = json.decode(response.body);
      List<ActivityModel> activities = List<ActivityModel>.from(
          l.map((model) => ActivityModel.fromJson(model)));
      return activities;
    }
  }
}
