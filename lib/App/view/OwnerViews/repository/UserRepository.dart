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

  Future<UserModel> getUserById(String id) async {
    try {
      // Map<String, String> queryParams = {
      //   'id': googleToken,
      // };
      // String queryString = Uri(queryParameters: queryParams).query;

      var requestUrl = url + id;

      final response = await get(requestUrl);
      UserModel user = UserModel.fromJson(json.decode(response.body));
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<UserModel> getUserByGoogleToken(String googleToken) async {
    try {
      // Map<String, String> queryParams = {
      //   'googleToken': googleToken,
      // };
      // String queryString = Uri(queryParameters: queryParams).query;

      var requestUrl = url + "googleToken/" + googleToken;

      final response = await get(requestUrl);
      UserModel user = UserModel.fromJson(json.decode(response.body));
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<UserModel> getUserByEmailToken(String emailToken) async {
    try {
      // Map<String, String> queryParams = {
      //   'emailToken': emailToken,
      // };
      // String queryString = Uri(queryParameters: queryParams).query;

      var requestUrl = url + 'emailToken/' + emailToken;

      final response = await get(requestUrl);
      UserModel user = UserModel.fromJson(json.decode(response.body));
      // List<UserModel> users =
      //     List<UserModel>.from(l.map((model) => UserModel.fromJson(model)));
      return user;
    } catch (e) {
      return null;
    }
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
    String user = json.decode(response.body);
    UserModel model = await getUserById(user);
    return model;
  }
}
