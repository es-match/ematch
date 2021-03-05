import 'package:ematch/App/controller/groupController.dart';
import 'package:ematch/App/controller/sign_in.dart';
import 'package:ematch/App/custom_widgets/groupCard.dart';
import 'package:ematch/App/model/groupModel.dart';
import 'package:ematch/App/view/UserViews/group/groupDetailsPage.dart';
import 'package:ematch/App/view/UserViews/group/newGroup_page.dart';
import 'package:flutter/material.dart';
import 'package:simple_search_bar/simple_search_bar.dart';

GroupController groupController = GroupController();

class GroupPage extends StatefulWidget {
  @override
  _GroupPageState createState() => _GroupPageState();
}

final AppBarController appBarController = AppBarController();
Future<List<GroupModel>> model;

class _GroupPageState extends State<GroupPage> {
  @override
  void initState() {
    super.initState();
    groupController = GroupController();
    getUserGroups();
  }

  getUserGroups() {
    model = groupController.getGroupsByUserID(myUserid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Grupos"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              getUserGroups();
              setState(() {});
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: model,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return buildGroupColumn(snapshot.data);
          else
            return Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: RaisedButton(
        child: Text('Criar um Grupo'),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewGroupPage()),
        ),
      ),
    );
  }

  Column buildGroupColumn(List<GroupModel> groupList) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: groupList.length,
            itemBuilder: (context, index) {
              // String groupName = groupList[index].groupName;
              GroupModel currentGroup = groupList[index];
              return ListTile(
                title: InkWell(
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  GroupDetailsPage(group: currentGroup)),
                        ),
                    child: GroupCard(group: currentGroup)),
              );
            },
          ),
        )
      ],
    );
  }
}
