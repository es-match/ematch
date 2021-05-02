import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';

const publicKey = "TEST-0362a415-974e-4498-899e-290f3889ee73";
const preferenceId = "161144975-e44465ae-b01e-4813-bfc3-b133d502f9ff";

Future<String> createBillMP() async {
  const body = {
    "items": [
      {
        "title": "Dummy Item",
        "description": "Multicolor Item",
        "quantity": 1,
        "currency_id": "ARS",
        "unit_price": 10.0
      }
    ],
    "payer": {"email": "payer@email.com"}
  };
}

Future<String> paymentMP(String preferenceID) async {
  PaymentResult result = await MercadoPagoMobileCheckout.startCheckout(
    publicKey,
    preferenceId,
  );
  print(result.toString());
}
