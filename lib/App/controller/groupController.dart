import 'package:ematch/App/model/groupModel.dart';
import 'package:ematch/App/repository/groupRepository.dart';

class GroupController {
  GroupRepository repository = GroupRepository();

  Future<List<GroupModel>> getGroupsByUserID(String userID) {
    return repository.getGroupsByUserID(userID);
  }

  Future<List<GroupModel>> getGroups() {
    return repository.getGroups();
  }

  Future<List<GroupModel>> getGroupsByName(String groupName) {
    return repository.getGroupsByName(groupName);
  }

  Future<GroupModel> insertGroup(GroupModel group) {
    return repository.insertGroup(group);
  }

  Future<GroupModel> followGroup(GroupModel group, String userID) {
    group.groupUsers.add(userID);
    return repository.updateGroup(group);
  }

  Future<GroupModel> unfollowGroup(GroupModel group, String userID) {
    group.groupUsers.remove(userID);
    return repository.updateGroup(group);
  }
}
