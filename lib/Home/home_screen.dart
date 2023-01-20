import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? paymentIntentData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Strip Payment"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await makePayment();
          },
          child: const Text("Buy"),
        ),
      ),
    );
  }

  Future<void> makePayment() async {
    try {
      paymentIntentData = await createPaymentIntent("200", "US");
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        //: const PaymentSheetGooglePay(testEnv: true, currencyCode: ""),
        merchantDisplayName: "Prospects",
        customerId: paymentIntentData!['customer'],
        style: ThemeMode.dark,
        paymentIntentClientSecret: paymentIntentData!['client_secret'],
        customerEphemeralKeySecret: paymentIntentData!['ephemeralkey'],
      ));
      displayPaymentSheet();
    } catch (e, s) {
      print("adnan++++++++++++++ $e$s");
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculationAmount(amount),
        'currency': currency,
        "payment_method_type[]": "card",
      };

      var responce = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        headers: {
          ///TODO:adding the Secret key
          'Authorization': "Bearer Enter Secret key",
          'Content-type': "application/x-www-form-urlencoded"
        },
        body: body,
      );
      print('adii${responce.body.toString()}');
      return jsonDecode(responce.body);
    } catch (e) {
      print("Charge ++++++++++++++ $e");
    }
  }

  void displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      Get.snackbar(
        "Information",
        "Successfully",
        icon: const Icon(Icons.error_outline, color: Colors.white),
        snackPosition: SnackPosition.TOP,
      );
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Strip++++++++++++++ $e");
      } else {
        print("Strip Error+++++++++==$e");
      }
    } catch (e) {
      print("adnan++++++++++++++ $e");
    }
  }

  calculationAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
