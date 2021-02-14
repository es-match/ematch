import 'package:ematch/UserApp/views/main_page.dart';
import 'package:flutter/material.dart';

Map<String, Widget> userPageWidgers = getUserPageWidgetList();

class TestPageViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TEST PAGE VIEWER"),
      ),
      body: ListView(
        children: [
          Text("User Pages"),
          ListTile(
            title: UserPageListView(),
          ),
        ],
      ),
    );
  }
}

class UserPageListView extends StatelessWidget {
  const UserPageListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: userPageWidgers.length,
        itemBuilder: (context, index) {
          String key = userPageWidgers.keys.elementAt(index);
          return ListTile(
            title: RaisedButton(
              child: Text('$key'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => userPageWidgers[key]),
              ),
            ),
          );
        });
  }
}

Map<String, Widget> getUserPageWidgetList() {
  Map _widgets = Map<String, Widget>();
  _widgets["MainPage"] = MainPage();

  return _widgets;
}
