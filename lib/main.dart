import 'package:ematch/App/view/UserViews/main_page.dart';
import 'package:ematch/_TESTCONTROLWIDGETS/testpageviewer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var materialApp = LitAuthInit(
    //   child:
    var materialApp = MaterialApp(
      title: "E.S.Match",
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TestPageViewer(),
        '/home': (context) => MainPage(),
      },
    );
    return materialApp;
  }
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //       title: 'E.S.MATCH',
  //       theme: ThemeData(
  //         primarySwatch: Colors.deepOrange,
  //       ),
  //       // home: LoginPage(),
  //       home: TestPageViewer() //MainPage(),
  //       );
  // }
}
