import 'package:ematch/App/controller/userController.dart';
import 'package:ematch/App/model/userModel.dart';
import 'package:flutter/material.dart';

class GroupParticipantsPage extends StatefulWidget {
  final List<String> pendingList;
  final List<String> adminList;
  final List<String> userList;

  GroupParticipantsPage({this.pendingList, this.adminList, this.userList});

  @override
  _GroupParticipantsPageState createState() => _GroupParticipantsPageState();
}

class _GroupParticipantsPageState extends State<GroupParticipantsPage> {
  UserController _controller = UserController();
  // List<String> _pendingList;
  // List<String> _adminList;
  List<String> _userList;
  Future<List<UserModel>> getUsersByListIDs;
  List<UserModel> groupUsers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // _pendingList = widget.pendingList;
    // _adminList = widget.adminList;
    _userList = widget.userList;
    getUsersByListIDs = _controller.getUsersByListIDs(_userList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Participantes do Grupo"),
      ),
      body: FutureBuilder(
        future: Future.wait([getUsersByListIDs]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            groupUsers = snapshot.data[0];
            return buildBody();
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  ListView buildBody() {
    return ListView.builder(
      itemCount: groupUsers.length,
      itemBuilder: (context, index) {
        UserModel user = groupUsers[index];
        return ListTile(
          title: Card(
            child: Container(child: Text(user.userName)),
          ),
        );
      },
    );
  }
}
