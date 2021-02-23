import 'dart:convert';
import 'package:ematch/OwnerApp/model/userModel.dart';
import 'package:http/http.dart';

class UserRepository {
  final url =
      "https://us-central1-esmatch-ce3c9.cloudfunctions.net/dbUsers/api/v1/users/";

  Future<List<UserModel>> getUsers() async {
    final response = await get(url);
    Iterable l = json.decode(response.body);
    List<UserModel> users =
        List<UserModel>.from(l.map((model) => UserModel.fromJson(model)));
    return users;
  }

  Future<UserModel> getUserByGoogleToken(String googleToken) async {
    try {
      Map<String, String> queryParams = {
        'googleToken': googleToken,
      };
      String queryString = Uri(queryParameters: queryParams).query;

      var requestUrl = url + '?' + queryString;

      final response = await get(requestUrl);
      Iterable l = json.decode(response.body);
      List<UserModel> users =
          List<UserModel>.from(l.map((model) => UserModel.fromJson(model)));
      return users[0];
    } catch (e) {
      return null;
    }
  }

  Future<UserModel> getUserByEmailToken(String emailToken) async {
    Map<String, String> queryParams = {
      'emailToken': emailToken,
    };
    String queryString = Uri(queryParameters: queryParams).query;

    var requestUrl = url + '?' + queryString;

    final response = await get(requestUrl);
    UserModel user = UserModel.fromJson(json.decode(response.body));
    return user;
  }

  Future<UserModel> insertUser(UserModel userModel) async {
    dynamic jsonUser = json.encode(userModel.toJson());
    final Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await post(
      url,
      body: jsonUser,
      headers: headers,
    );
    UserModel user = UserModel.fromJson(json.decode(jsonUser));
    return user;
  }
}
