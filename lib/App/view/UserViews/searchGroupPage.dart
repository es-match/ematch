import 'dart:collection';

import 'package:ematch/App/controller/groupController.dart';
import 'package:ematch/App/custom_widgets/groupCard.dart';
import 'package:ematch/App/model/groupModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchGroupPage extends StatefulWidget {
  @override
  _SearchGroupPageState createState() => _SearchGroupPageState();
}

class _SearchGroupPageState extends State<SearchGroupPage> {
  Future<List<GroupModel>> model;

  GroupController searchGroupController;

  @override
  void initState() {
    super.initState();
    searchGroupController = GroupController();
    getGroups('');
  }

  static const List<String> _kOptions = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
  ];

  getGroups(String value) {
    model = searchGroupController.getGroups();
  }

  onFilterTap(String value) {
    setState(() {
      model = value == ''
          ? searchGroupController.getGroups()
          : searchGroupController.getGroupsByName(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text("Buscar Grupos"),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.white,
              child: TextField(
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(prefixIcon: Icon(Icons.search)),
                onChanged: onFilterTap,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: FutureBuilder(
                future: model,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done)
                    return buildGroupColumn(snapshot.data);
                  else
                    return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ],
      ),
      // ignore: deprecated_member_use
    );
  }

  Column buildGroupColumn(List<GroupModel> groupList) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
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
                    // onTap: (){} => Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) =>
                    //               GroupDetailsPage(group: currentGroup)),
                    //     ),
                    child: GroupCard(group: currentGroup)),
              );
            },
          ),
        )
      ],
    );
  }
}
