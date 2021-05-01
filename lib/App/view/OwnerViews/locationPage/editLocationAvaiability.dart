import 'package:ematch/App/controller/locationController.dart';
import 'package:ematch/App/model/locationModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

  TextEditingController hourValueController = TextEditingController();

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
      daysList[el.trim().toUpperCase()] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.location.locationName),
            Row(
              children: [
                Icon(Icons.calendar_today_outlined),
                Text("  Ajustar Disponibilidade:"),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(
                20,
              )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "R\$/Hora:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.grey[800],
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: hourValueController,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.orangeAccent, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Text(
                        "Horários disponíveis para reserva:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      buildHourListView(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                buildDaysListView(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          controller.editAvaiability(widget.location.id, hoursList, daysList,
              hourValueController.text);
        },
        child: Container(
          height: MediaQuery.of(context).size.height / 15,
          width: MediaQuery.of(context).size.width / 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.save,
                size: 30,
              ),
              Text(
                "  Salvar",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }

  Container buildHourListView() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        shrinkWrap: true,
        children: hoursList.keys.map((e) {
          var curNum = e.toString().padLeft(2, '0');
          // return ListTile(title: Text("$curNum:00 - $curNum:59"));
          return CheckboxListTile(
            contentPadding: EdgeInsets.all(0),
            title: Row(
              children: [
                Icon(Icons.arrow_forward),
                Text(
                  "$curNum:00 - $curNum:59",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
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
      height: MediaQuery.of(context).size.height * 0.10,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[800],
      ),
      alignment: Alignment.center,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: daysList.keys.map((e) {
          // return ListTile(title: Text("$curNum:00 - $curNum:59"));
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                e,
                textAlign: TextAlign.center,
              ),
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
