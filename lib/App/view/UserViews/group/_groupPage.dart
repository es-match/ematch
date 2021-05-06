import 'package:ematch/App/controller/groupController.dart';
import 'package:ematch/App/controller/sign_in.dart';
import 'package:ematch/App/custom_widgets/groupCard.dart';
import 'package:ematch/App/model/groupModel.dart';
import 'package:ematch/App/view/UserViews/group/groupDetailsPage.dart';
import 'package:ematch/App/view/UserViews/group/insertGroupPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.people),
            Text(" Meus Grupos"),
          ],
        ),
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
      // ignore: deprecated_member_use
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          height: MediaQuery.of(context).size.height / 13,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  size: 50,
                ),
                Text(
                  '  Criar um Grupo',
                  style: TextStyle(fontSize: 27),
                ),
              ],
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewGroupPage(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column buildGroupColumn(List<GroupModel> groupList) {
    if (groupList == null || groupList.length == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text:
                      "Sem grupos atuais :(\nQue tal começar um novo grupo abaixo. ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    wordSpacing: 5,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: groupList != null ? groupList.length : 0,
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
}
