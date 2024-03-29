import 'package:ematch/App/controller/eventController.dart';
import 'package:ematch/App/controller/mercadopagoService.dart';
import 'package:ematch/App/controller/sign_in.dart';
import 'package:ematch/App/model/eventModel.dart';
import 'package:ematch/App/model/groupModel.dart';
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
  final GroupModel group;

  const PaymentCheckinPage(
      {Key key,
      this.location,
      this.eventDay,
      this.startHour,
      this.endHour,
      this.group})
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
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Checkin de Pagamento"),
      ),
      body: buildBody(context),
      floatingActionButton: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) return Colors.green;
                return Colors.lightBlue; // Use the component's default.
              },
            ),
          ),
          onPressed: () {
            payAndAlocateEvent();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.payment),
              Text(
                "Realizar Pagamento",
                style: TextStyle(fontSize: 20),
              ),
            ],
          )),
    );
  }

  Future<String> payAndAlocateEvent() async {
    var formatedDate = DateFormat("dd/MM/yyyy").format(widget.eventDay);

    var formatedStart = "${widget.startHour.padLeft(2, '0')}:00";
    var formatedEnd = "${widget.endHour.padLeft(2, '0')}:59";
    var _unitPrice = double.parse(widget.location.hourValue);

    PaymentModel payModel = PaymentModel(
        description:
            "Reserva Quadra ${widget.location.locationName} no dia $formatedDate das ${formatedStart}hrs as ${formatedEnd}hrs.",
        email: myEmail,
        quantity: totalHours,
        title: "Reserva Quadra ${widget.location.locationName}.",
        unitPrice: _unitPrice);

    var res = await paymentMP(await createBillMP(payModel, context));

    if (res.status.toString() == "approved") {
      var _startDate =
          widget.eventDay.add(Duration(hours: int.parse(widget.startHour)));

      var _endDate = widget.eventDay
          .add(Duration(hours: int.parse(widget.endHour), minutes: 59));

      EventModel curEvent = EventModel(
          userID: myUserid,
          eventName: "",
          locationID: widget.location.id,
          groupID: widget.group.id,
          startDate: _startDate.toIso8601String(),
          endDate: _endDate.toIso8601String());

      EventModel ev = await eventController.insertEvent(curEvent);

      if (ev != null && ev.id != null) {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => EventDetailPage(model: ev)));
      }
    }
  }

  Container buildBody(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Resumo",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              color: Colors.grey[600],
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildReviewTable(),
            ),
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
