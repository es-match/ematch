import 'package:ematch/App/model/userModel.dart';
import 'package:ematch/App/repository/userRepository.dart';

class UserController {
  UserRepository _repository = UserRepository();

  Future<List<UserModel>> getUsersByListIDs(List<String> userIDList) async {        
      return _repository.getUserByList(userIDList);            
  }
}
