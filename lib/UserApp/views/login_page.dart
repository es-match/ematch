// import 'package:ematch/controllers/sign_in.dart';
import 'package:ematch/UserApp/controllers/sign_in.dart';
import 'package:ematch/UserApp/custom_widgets/background_painter.dart';
import 'package:flutter/material.dart';

import 'main_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: CustomPaint(
              painter: BackgroundPainter(
                animation: _controller.view,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RaisedButton(
                    color: Colors.blueGrey,
                    onPressed: () {
                      _controller.reverse(from: 2);
                    },
                    child: Text('Sign In'),
                  ),
                  RaisedButton(
                    color: Colors.blueGrey,
                    onPressed: () {
                      _controller.forward(from: 0);
                    },
                    child: Text('Sign Up'),
                  ),
                  _signInButton(),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
    // Widget build(BuildContext context) {
    //   return Scaffold(
    //     body: Container(
    //       decoration: BoxDecoration(
    //         gradient: LinearGradient(
    //             begin: Alignment.topRight,
    //             end: Alignment.bottomLeft,
    //             colors: [
    //               // Colors.orange[900],
    //               // Colors.orange[800],
    //               Colors.blue,
    //               // Colors.deepOrange[500],
    //               // Colors.orange,
    //             ],
    //             stops: [
    //               // 0.1,
    //               // 0.2,
    //               0.1,
    //               //  0.6,
    //               // 0.9,
    //             ]),
    //       ),
    //       child: Center(
    //         child: Column(
    //           mainAxisSize: MainAxisSize.max,
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: <Widget>[
    //             Image(image: AssetImage("assets/logoesm.png"), height: 150.0),
    //             SizedBox(height: 50),
    //             _signInButton(),
    //           ],
    //         ),
    //       ),
    //     ),
    //   );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.white,
      onPressed: () {
        signInWithGoogle().then((result) {
          if (result != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return MainPage();
                },
              ),
            );
          }
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
