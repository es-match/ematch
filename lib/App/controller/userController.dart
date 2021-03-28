import 'package:ematch/App/model/userModel.dart';
import 'package:ematch/App/repository/userRepository.dart';

class UserController {
  UserRepository _repository = UserRepository();

  Future<List<UserModel>> getUsersByListIDs(List<String> userIDList) async {
    List<UserModel> finalList = [];
    userIDList.forEach((userID) async {
      UserModel userData = await _repository.getUserById(userID);
      finalList.add(userData);
    });

    return finalList;
  }
}
