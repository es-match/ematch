import 'dart:ffi';

import 'package:ematch/App/controller/eventController.dart';
import 'package:ematch/App/controller/mercadopagoService.dart';
import 'package:ematch/App/controller/sign_in.dart';
import 'package:ematch/App/model/locationModel.dart';
import 'package:ematch/App/model/paymentModel.dart';
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
//  "title": "Reserva Quadra Bar100Lona",
//             "description": "Reserva da Quadra Bar100Lona no dia 03/05/2021 das 08:00hrs as 11:59hrs.",
//             "quantity": 3,
//             "currency_id": "BRL",
//             "category_id": "sport",
//             "picture_url": "https://www.mercadopago.com/org-img/MP3/home/logomp3.gif",
//             "unit_price": 80.0

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
      // eventController.insertEvent(widget.location);
    }
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
            // Divider(),
            // Text("Método de Pagamento"),
            // Divider(),
            // ElevatedButton(
            //   onPressed: () {
            //     print("Pagar com Cartão de Crédito");
            //   },
            //   child: Text("Cartão de Crédito"),
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     print("Pagar com Mercado Pago");
            //   },
            //   child: Text("Mercado Pago"),
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     print("Pagar com Pix");
            //   },
            //   child: Text("Pix"),
            // )
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
