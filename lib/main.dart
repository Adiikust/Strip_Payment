import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:strip_payment/Home/home_screen.dart';

import 'Paypal/paypal_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///TODO:adding the public key
  Stripe.publishableKey = "Publishable Key";

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Strip Payment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PaypalScreen(),
    );
  }
}
