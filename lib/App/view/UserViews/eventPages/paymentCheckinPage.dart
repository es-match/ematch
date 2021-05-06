import 'dart:ffi';

import 'package:ematch/App/controller/eventController.dart';
import 'package:ematch/App/controller/mercadopagoService.dart';
import 'package:ematch/App/controller/sign_in.dart';
import 'package:ematch/App/model/eventModel.dart';
import 'package:ematch/App/model/locationModel.dart';
import 'package:ematch/App/model/paymentModel.dart';
import 'package:ematch/App/view/UserViews/eventPages/eventDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentCheckinPage extends StatefulWidget {
  final LocationModel location;
  final DateTime eventDay;
  final String startHour;
  final String endHour;

  const PaymentCheckinPage(
      {Key key, this.location, this.eventDay, this.startHour, this.endHour})
      : super(key: key);
  @override
  _PaymentCheckinPageState createState() => _PaymentCheckinPageState();
}

class _PaymentCheckinPageState extends State<PaymentCheckinPage> {
  var totalHours;
  var paymentTotal;

  @override
  void initState() {
    super.initState();
    totalHours = int.parse(widget.endHour ?? "0") -
        int.parse(widget.startHour ?? "0") +
        1;
    paymentTotal =
        (int.parse(widget.location.hourValue) * totalHours).toString();
  }

  EventController eventController = EventController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkin de Pagamento"),
      ),
      body: buildBody(context),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            payAndAlocateEvent();
          },
          child: Text("Realizar Pagamento")),
    );
  }

  Future<String> payAndAlocateEvent() async {
    var _startDate =
        widget.eventDay.add(Duration(hours: int.parse(widget.startHour)));

    var _endDate = widget.eventDay
        .add(Duration(hours: int.parse(widget.endHour), minutes: 59));

    EventModel curEvent = EventModel(
        userID: myUserid,
        eventName: "",
        locationID: widget.location.id,
        groupID: "000001",
        startDate: _startDate.toIso8601String(),
        endDate: _endDate.toIso8601String());

    EventModel ev = await eventController.insertEvent(curEvent);

    if (ev != null && ev.id != null) {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => EventDetailPage(model: ev)));
    }
    // }
  }

  Container buildBody(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Resumo"),
            Divider(),
            buildReviewTable(),
          ],
        ));
  }

  Table buildReviewTable() {
    return Table(
      border: TableBorder.all(
          color: Colors.black, width: 1, style: BorderStyle.solid),
      children: [
        TableRow(
          children: [
            Text(
              "Local",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              widget.location.locationName,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        TableRow(
          children: [
            Text(
              "Data",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              DateFormat("dd/MM/yyyy").format((widget.eventDay)),
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        TableRow(
          children: [
            Text(
              "Horário",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "${widget.startHour.padLeft(2, '0')}:00 - ${widget.endHour.padLeft(2, '0')}:59",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            Text(
              "Total a pagar",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "R\$ $paymentTotal,00",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
