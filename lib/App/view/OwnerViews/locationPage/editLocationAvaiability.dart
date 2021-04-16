import 'package:ematch/App/model/locationModel.dart';
import 'package:flutter/material.dart';

class EditLocationAvaiability extends StatefulWidget {
  final LocationModel location;
  EditLocationAvaiability(this.location);

  @override
  _EditLocationAvaiabilityState createState() =>
      _EditLocationAvaiabilityState();
}

class _EditLocationAvaiabilityState extends State<EditLocationAvaiability> {
  Map<int, bool> hoursList;

  @override
  void initState() {
    // TODO: implement initState

    Iterable<int>.generate(24).forEach((e) {
      hoursList[e] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView(
            children: hoursList.keys.map((e){
              return CheckboxListTile(value: hoursList[e], onChanged: (value) {
                setState((){
                  hoursList[e] = value;
                });
                
              },);
            }
            )
  }
}
