import 'dart:convert';
import 'package:ematch/App/model/paymentModel.dart';
import 'package:http/http.dart';

class PaymentRepository {
  final String url =
      "https://api.mercadopago.com/checkout/preferences?access_token=TEST-3670125385404362-050218-f57af0447a1ea01927456c73d87174a9-161144975";

  Future<String> getPaymentBill(PaymentModel paymentDetails) async {
    // var _body = paymentDetails.toJsonBillMP();
    var _body = paymentDetails.toJsonBillMP();





    // String path =
    //     "http://localhost:5001/esmatch-ce3c9/us-central1/dbGroups/api/v1/groups/";
    final response = await post(
      url,
      // path,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: _body,
    );

    print(response.statusCode);
    Map<String, dynamic> l;
    if (response.statusCode == 200 || response.statusCode == 201) {
      l = json.decode(response.body);
    }
    return l['id'].toString();
  }
}
