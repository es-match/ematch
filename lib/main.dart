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
        textTheme: Theme.of(context)
            .textTheme
            .apply(bodyColor: Colors.white, displayColor: Colors.white),
        iconTheme: IconThemeData(color: Colors.white),
        cardTheme: CardTheme(color: Color.fromRGBO(69, 117, 104, 1)),
        scaffoldBackgroundColor: Colors.black,
        dividerTheme:
            DividerThemeData(color: Colors.white, thickness: 2, space: 2),
        unselectedWidgetColor: Colors.white,
        primarySwatch: Colors.deepOrange,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TestPageViewer(), //LoginPage(),
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
