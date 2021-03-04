import 'package:ematch/App/model/groupModel.dart';
import 'package:ematch/App/repository/groupRepository.dart';

class GroupController {
  GroupRepository repository = GroupRepository();

  Future<List<GroupModel>> getGroupsByUserID(String userID) {
    return repository.getGroupsByUserID(userID);
  }
}
