import 'dart:io';

import 'package:ematch/App/controller/activitiesController.dart';
import 'package:ematch/App/controller/groupController.dart';
import 'package:ematch/App/controller/sign_in.dart';
import 'package:ematch/App/model/activityModel.dart';
import 'package:ematch/App/model/groupModel.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

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

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    asyncMethods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      drawerScrimColor: Colors.white,
      appBar: AppBar(
        title: Text('Novo Grupo'),
      ),
      body: activityList == null
          ? Center(
              child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ))
          : Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(20),
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildBody(),
              )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (formkey.currentState.validate()) {
            formkey.currentState.save();
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Dialog(
                  backgroundColor: Colors.white60,
                  child: new Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      new CircularProgressIndicator(),
                      new SizedBox(
                        height: 10,
                      ),
                      new Text(" Criando grupo..."),
                    ],
                  ),
                );
              },
            );

            GroupModel group = GroupModel();
            group.groupName = tituloController.text;
            group.groupDescription = descricaoController.text;
            group.imageUrl = _selectedActivity.imageUrl;
            group.activityID = _selectedActivity.id;
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
          }
        },

        child: Icon(
          Icons.add,
          size: 32,
        ),
        // child: Text(
        //   "+",
        //   style: TextStyle(
        //     fontSize: 50,
        //   ),
        // ),
      ),
    );
  }

  ListView buildBody() {
    return ListView(
      children: [
        ListTile(
          title: Form(
            key: formkey,
            child: Column(
              children: [
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Text('Título do Grupo'),
                // ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  validator: MultiValidator([
                    RequiredValidator(
                      errorText: "Campo Obrigatório",
                    )
                  ]),
                  controller: tituloController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    alignLabelWithHint: true,
                    labelText: 'Título do Grupo',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.deepOrange,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[800],
                        width: 1.0,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.redAccent[700],
                        width: 1.0,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.deepOrange,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  // child: Divider(),
                ),
                TextFormField(
                  controller: descricaoController,
                  maxLines: 5,
                  maxLength: 300,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  validator: MultiValidator([
                    RequiredValidator(
                      errorText: "Campo Obrigatório",
                    )
                  ]),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    labelText: 'Descrição do Grupo',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.deepOrange,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[800],
                        width: 1.0,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.redAccent[700],
                        width: 1.0,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.deepOrange,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  // child: Divider(),
                ),
                Text(
                  "Selecione a atividade:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                activityList == null
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        children: buildRadioList(),
                      ),
                // Divider(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> buildRadioList() {
    var radiobuttons = <RadioListTile>[];
    activityList.forEach((element) {
      return radiobuttons.add(RadioListTile<ActivityModel>(
        activeColor: Colors.deepOrangeAccent,
        title: Text(
          element.activityName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
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

    _selectedActivity = activityList.first;
    setState(() {});
  }
}
