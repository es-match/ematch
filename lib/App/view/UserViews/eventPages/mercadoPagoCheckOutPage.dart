import 'package:ematch/App/controller/mercadopagoService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MercadoPagoCheckout extends StatefulWidget {
  @override
  _MercadoPagoCheckoutState createState() => _MercadoPagoCheckoutState();
}

class _MercadoPagoCheckoutState extends State<MercadoPagoCheckout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagamento via MercadoPago"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                paymentMP("teste");
              },
              child: Text(
                "Pagamento",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
