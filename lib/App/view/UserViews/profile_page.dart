import 'package:ematch/App/controller/sign_in.dart';
import 'package:ematch/App/custom_widgets/background_painter.dart';
import 'package:flutter/material.dart';

import '../loginPage.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepOrange[500],
              Colors.deepOrange[600],
              Colors.deepOrange[700],
              Colors.deepOrange[800],
              Colors.deepOrange[900],
              // Colors.orange,
            ],
            stops: [
              0.2,
              0.4,
              0.6,
              0.7,
              0.9,
              // 0.9,
            ]),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(
                myImageurl,
              ),
              radius: 60,
              backgroundColor: Colors.transparent,
            ),
            SizedBox(height: 40),
            Text(
              'NAME',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
            Text(
              myName,
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'EMAIL',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
            Text(
              myEmail,
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            // ignore: deprecated_member_use
            RaisedButton(
              onPressed: () {
                signOutUser();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }), ModalRoute.withName('/'));
              },
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Sair',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
            )
          ],
        ),
      ),
    );
  }
}
