import 'package:ematch/App/model/locationModel.dart';
import 'package:flutter/material.dart';
import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';
import 'package:ematch/App/model/paymentModel.dart';

const publicKey = "TEST-0362a415-974e-4498-899e-290f3889ee73";
const preferenceId = "161144975-bc528f33-4ccc-42c4-8ecb-90dfde5bf084";

Future<String> createBillMP(PaymentModel payment, BuildContext context) async {
  try {
    //https://api.mercadopago.com/checkout/preferences?access_token=TEST-3670125385404362-050218-f57af0447a1ea01927456c73d87174a9-161144975
    return "161144975-bc528f33-4ccc-42c4-8ecb-90dfde5bf084";
  } catch (error) {
    return null;
  }
}

Future<PaymentResult> paymentMP(String preferenceID) async {
  PaymentResult result = await MercadoPagoMobileCheckout.startCheckout(
    publicKey,
    preferenceID,
  );
  return result;
}
