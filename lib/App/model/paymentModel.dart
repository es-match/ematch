import 'dart:ffi';

class PaymentModel {
  String title;
  String description;
  Int32 quantity;
  Float unit_price;
  String email;

  PaymentModel(
      {this.title,
      this.description,
      this.quantity,
      this.unit_price,
      this.email});

  Map<String, dynamic> toJsonBillMP() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['items'] = {
      "title": this.title,
      "description": this.description,
      "quantity": this.quantity,
      "currency_id": "BRL",
      "category_id": "sport",
      "picture_url": "https://www.mercadopago.com/org-img/MP3/home/logomp3.gif",
      "unit_price": this.unit_price
    };
    data['payer'] = {"email": this.email};
    data['payment_methods'] = {
      "excluded_payment_types": [
        {"id": "ticket"}
      ],
      "installments": 12
    };
    data['expires'] = true;
    data['expiration_date_from'] = DateTime.now();
    data['expiration_date_to'] = DateTime.now().add(const Duration(days: 1));

    return data;
  }
}

//CHAMADA
// {
//     "items": [
//         {
//             "title": "Reserva Quadra Bar100Lona",
//             "description": "Reserva da Quadra Bar100Lona no dia 03/05/2021 das 08:00hrs as 11:59hrs.",
//             "quantity": 3,
//             "currency_id": "BRL",
//             "category_id": "sport",
//             "picture_url": "https://www.mercadopago.com/org-img/MP3/home/logomp3.gif",
//             "unit_price": 80.0
//         }
//     ],
//     "payer": {
//         "email": "payer@email.com"
//     },
//     "payment_methods": {

//         "excluded_payment_types": [
//             {
//                 "id": "ticket"
//             }
//         ],
//         "installments": 12
//     },
//     "expires": true,
//     "expiration_date_from": "2021-02-01T12:00:00.000-04:00",
//     "expiration_date_to": "2022-02-28T12:00:00.000-04:00"
// }

//RESPOSTA
// {
//     "additional_info": "",
//     "auto_return": "",
//     "back_urls": {
//         "failure": "",
//         "pending": "",
//         "success": ""
//     },
//     "binary_mode": false,
//     "client_id": "3670125385404362",
//     "collector_id": 161144975,
//     "coupon_code": null,
//     "coupon_labels": null,
//     "date_created": "2021-05-03T01:06:09.419+00:00",
//     "date_of_expiration": null,
//     "expiration_date_from": "2021-02-01T12:00:00.000-04:00",
//     "expiration_date_to": "2022-02-28T12:00:00.000-04:00",
//     "expires": true,
//     "external_reference": "",
//     "id": "161144975-bc528f33-4ccc-42c4-8ecb-90dfde5bf084",
//     "init_point": "https://www.mercadopago.com.br/checkout/v1/redirect?pref_id=161144975-bc528f33-4ccc-42c4-8ecb-90dfde5bf084",
//     "internal_metadata": null,
//     "items": [
//         {
//             "id": "",
//             "category_id": "sport",
//             "currency_id": "BRL",
//             "description": "Reserva da Quadra Bar100Lona no dia 03052021 das 08:00hrs as 11:59hrs.",
//             "picture_url": "https://www.mercadopago.com/org-img/MP3/home/logomp3.gif",
//             "title": "Reserva Quadra Bar100Lona",
//             "quantity": 3,
//             "unit_price": 80
//         }
//     ],
//     "marketplace": "NONE",
//     "marketplace_fee": 0,
//     "metadata": {},
//     "notification_url": null,
//     "operation_type": "regular_payment",
//     "payer": {
//         "phone": {
//             "area_code": "",
//             "number": ""
//         },
//         "address": {
//             "zip_code": "",
//             "street_name": "",
//             "street_number": null
//         },
//         "email": "payer@email.com",
//         "identification": {
//             "number": "",
//             "type": ""
//         },
//         "name": "",
//         "surname": "",
//         "date_created": null,
//         "last_purchase": null
//     },
//     "payment_methods": {
//         "default_card_id": null,
//         "default_payment_method_id": null,
//         "excluded_payment_methods": [
//             {
//                 "id": ""
//             }
//         ],
//         "excluded_payment_types": [
//             {
//                 "id": "ticket"
//             }
//         ],
//         "installments": 12,
//         "default_installments": null
//     },
//     "processing_modes": null,
//     "product_id": null,
//     "redirect_urls": {
//         "failure": "",
//         "pending": "",
//         "success": ""
//     },
//     "sandbox_init_point": "https://sandbox.mercadopago.com.br/checkout/v1/redirect?pref_id=161144975-bc528f33-4ccc-42c4-8ecb-90dfde5bf084",
//     "site_id": "MLB",
//     "shipments": {
//         "default_shipping_method": null,
//         "receiver_address": {
//             "zip_code": "",
//             "street_name": "",
//             "street_number": null,
//             "floor": "",
//             "apartment": "",
//             "city_name": null,
//             "state_name": null,
//             "country_name": null
//         }
//     },
//     "total_amount": null,
//     "last_updated": null
// }
