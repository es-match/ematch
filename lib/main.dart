import 'package:ematch/views/login_page.dart';
import 'package:ematch/views/main_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  @override
  // Widget build(BuildContext context) {
  //   var materialApp = MaterialApp(
  //     theme: ThemeData(
  //       primarySwatch: Colors.deepOrange,
  //     ),
  //     initialRoute: '/',
  //     routes: {
  //       '/': (context) => LoginPage(),
  //       '/home': (context) => MainPage(),
  //     },
  //   );
  //   return materialApp;
  // }
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E.S.MATCH',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: LoginPage(),
      // home: MainPage(),
    );
  }
}
