import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

class PaypalScreen extends StatefulWidget {
  const PaypalScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PaypalScreen> createState() => _PaypalScreenState();
}

class _PaypalScreenState extends State<PaypalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Paypal Payment"),
        ),
        body: Center(
          child: TextButton(
              onPressed: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => buildUsePaypal(),
                      ),
                    )
                  },
              child: const Text("Make Payment")),
        ));
  }

  UsePaypal buildUsePaypal() {
    return UsePaypal(
        sandboxMode: true,

        ///TODO:Enter Client ID
        clientId: "",

        ///TODO:Enter secret ID
        secretKey: "",
        returnURL: "https://samplesite.com/return",
        cancelURL: "https://samplesite.com/cancel",
        transactions: const [
          {
            "amount": {
              "total": '10.12',
              "currency": "USD",
              "details": {
                "subtotal": '10.12',
                "shipping": '0',
                "shipping_discount": 0
              }
            },
            "description": "The payment transaction description.",
            // "payment_options": {
            //   "allowed_payment_method":
            //       "INSTANT_FUNDING_SOURCE"
            // },
            "item_list": {
              "items": [
                {
                  "name": "A demo product",
                  "quantity": 1,
                  "price": '10.12',
                  "currency": "USD"
                }
              ],

              // shipping address is not required though
              "shipping_address": {
                "recipient_name": "Jane Foster",
                "line1": "Travis County",
                "line2": "",
                "city": "Austin",
                "country_code": "US",
                "postal_code": "73301",
                "phone": "+00000000",
                "state": "Texas"
              },
            }
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          print("onSuccess: $params");
        },
        onError: (error) {
          print("onError: $error");
        },
        onCancel: (params) {
          print('cancelled: $params');
        });
  }
}
