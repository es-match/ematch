import 'package:flutter/material.dart';

class OverViewPage extends StatefulWidget {
  @override
  _OverViewPageState createState() => _OverViewPageState();
}

class _OverViewPageState extends State<OverViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OverviewPage"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: RaisedButton(
              onPressed: () => print("x"),
              child: Text("Adicionar Novo Local"),
            ),
          ),
        ),
      ),
    );
  }
}
