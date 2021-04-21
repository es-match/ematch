import 'package:ematch/App/controller/locationController.dart';
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
  LocationController controller = LocationController();
  Map<String, bool> daysList = {
    "SEG": false,
    "TER": false,
    "QUA": false,
    "QUI": false,
    "SEX": false,
    "SAB": false,
    "DOM": false
  };

  @override
  void initState() {
    super.initState();
    var list = Iterable<int>.generate(24);

    hoursList =
        Map<int, bool>.fromIterable(list, key: (k) => k, value: (v) => false);

    widget.location.avaiableHours.split(',').toList().forEach((el) {
      try {
        int k = int.parse(el);
        hoursList[k] = true;
      } catch (e) {}
    });

    widget.location.avaiableDays.split(',').toList().forEach((el) {
      daysList[el.toUpperCase()] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHourListView(),
            buildDaysListView(),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          controller.editAvaiability(widget.location.id, hoursList, daysList);
        },
        child: Text("Salvar"),
      ),
      // ),
    );
  }

  Container buildHourListView() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        shrinkWrap: true,
        children: hoursList.keys.map((e) {
          var curNum = e.toString().padLeft(2, '0');
          // return ListTile(title: Text("$curNum:00 - $curNum:59"));
          return CheckboxListTile(
            contentPadding: EdgeInsets.all(0),
            title: Text("$curNum:00 - $curNum:59"),
            value: hoursList[e],
            onChanged: (value) {
              setState(() {
                hoursList[e] = value;
              });
            },
          );
        }).toList(),
      ),
    );
  }

  Container buildDaysListView() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: daysList.keys.map((e) {
          // return ListTile(title: Text("$curNum:00 - $curNum:59"));
          return Column(
            children: [
              Text(e),
              Checkbox(
                  value: daysList[e],
                  onChanged: (value) {
                    setState(() {
                      daysList[e] = value;
                    });
                  }),
            ],
          );
        }).toList(),
      ),
    );
  }
}
