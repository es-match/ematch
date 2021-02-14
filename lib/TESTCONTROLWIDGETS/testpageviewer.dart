import 'package:ematch/UserApp/views/main_page.dart';
import 'package:flutter/material.dart';

var userPageWidgets = getUserPageWidgetList();
var ownerPageWidgets = getOwnerPageWidgetList();

Map<String, Widget> getOwnerPageWidgetList() {
  Map _opwidgets = Map<String, Widget>();
  _opwidgets["MainPage"] = MainPage();

  return _opwidgets;
}

Map<String, Widget> getUserPageWidgetList() {
  Map _upwidgets = Map<String, Widget>();
  _upwidgets["MainPage"] = MainPage();

  return _upwidgets;
}

class TestPageViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TEST PAGE VIEWER"),
      ),
      body: ListView(
        children: [
          Text("Owner Pages"),
          ListTile(
              title: ListView.builder(
                  shrinkWrap: true,
                  itemCount: userPageWidgets.length,
                  itemBuilder: (context, index) {
                    String key = ownerPageWidgets.keys.elementAt(index);
                    return ListTile(
                      title: RaisedButton(
                        child: Text('$key'),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ownerPageWidgets[key]),
                        ),
                      ),
                    );
                  })),
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
        itemCount: userPageWidgets.length,
        itemBuilder: (context, index) {
          String key = userPageWidgets.keys.elementAt(index);
          return ListTile(
            title: RaisedButton(
              child: Text('$key'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => userPageWidgets[key]),
              ),
            ),
          );
        });
  }
}
