import 'package:ematch/App/view/UserViews/_userMainPage.dart';
import 'package:ematch/App/view/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
// ignore: unused_import
import 'package:ematch/_TESTCONTROLWIDGETS/testpageviewer.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(AppWidget()));
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
        '/': (context) => LoginPage(), //TestPageViewer(),
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
