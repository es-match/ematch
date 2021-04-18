import 'package:ematch/App/controller/activitiesController.dart';
import 'package:ematch/App/controller/groupController.dart';
import 'package:ematch/App/controller/sign_in.dart';
import 'package:ematch/App/model/activityModel.dart';
import 'package:ematch/App/model/groupModel.dart';
import 'package:flutter/material.dart';

import 'groupDetailsPage.dart';

class NewGroupPage extends StatefulWidget {
  @override
  _NewGroupPageState createState() => _NewGroupPageState();
}

class _NewGroupPageState extends State<NewGroupPage> {
  ActivityModel _selectedActivity;
  List<ActivityModel> activityList;

  ActivitiesController activitiesController = ActivitiesController();
  GroupController groupController = GroupController();

  TextEditingController tituloController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    asyncMethods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Grupo'),
      ),
      body: activityList == null
          ? Center(child: CircularProgressIndicator())
          : buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          GroupModel group = GroupModel();
          group.groupName = tituloController.text;
          group.groupDescription = descricaoController.text;
          group.imageUrl = _selectedActivity.imageUrl;
          group.sportID = _selectedActivity.id;
          group.groupPending = [];
          group.groupAdmins = [myUserid];
          group.userCreator = myUserid;
          group.groupUsers = [myUserid];
          group = await groupController.insertGroup(group);

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => GroupDetailsPage(group: group),
              ));
        },
        child: Text("Criar"),
      ),
    );
  }

  ListView buildBody() {
    return ListView(
      children: [
        ListTile(
          title: Column(
            children: [
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: Text('Título do Grupo'),
              // ),
              TextField(
                controller: tituloController,
                decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelText: 'Título do Grupo',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(),
              ),
              TextField(
                controller: descricaoController,
                maxLines: 5,
                maxLength: 50,
                decoration: InputDecoration(
                  labelText: 'Descrição do Grupo',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.orangeAccent, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(),
              ),
              Text("Selecione o esporte"),
              activityList == null
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      children: buildRadioList(),
                    ),
              Divider(),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> buildRadioList() {
    var radiobuttons = <RadioListTile>[];

    activityList.forEach((element) {
      return radiobuttons.add(RadioListTile<ActivityModel>(
        title: Text(element.sportName),
        value: element,
        groupValue: _selectedActivity,
        onChanged: (ActivityModel value) {
          setState(() {
            _selectedActivity = value;
          });
        },
      ));
    });
    return radiobuttons;
  }

  Future<List<ActivityModel>> getActivities() async {
    return await activitiesController.getActivities();
  }

  void asyncMethods() async {
    activityList = await getActivities();
    setState(() {});
  }
}
