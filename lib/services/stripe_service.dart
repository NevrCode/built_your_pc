import 'dart:convert';
import 'dart:developer';

import 'package:flutter_stripe/flutter_stripe.dart';
import "package:http/http.dart" as http;

class StripeService {
  StripeService._();
  static final StripeService instance = StripeService._();

  Future<void> makePayment(int amount) async {
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent(
          amount * 1000, "idr"); // stripe accepts cents

      if (paymentIntentClientSecret == null) return;

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: "Built Your PC",
        ),
      );

      await _processPayment();
    } catch (e) {
      if (e is StripeException && e.error.code == FailureCode.Canceled) {
        rethrow;
      } else {
        log(e.toString());
      }
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      Uri url = Uri.parse("https://api.stripe.com/v1/payment_intents");
      final response = await http.post(url, headers: {
        "Authorization":
            "Bearer sk_test_51QRpopAuTZ1Aldd1IQMbs2SHD3oznUkjPhFhpOu9Z8cJqSwvAdLPYzwzxxxBAi6N6gQxzaRx4Blw66bD7m2LD7ub00j2bVBkgR",
        "Content-Type": 'application/x-www-form-urlencoded'
      }, body: {
        'amount': '$amount',
        'currency': currency,
        'payment_method_types[]': 'card',
      });
      if (response.statusCode != 200) {
        throw Exception('Failed to create payment intent: ${response.body}');
      }
      final paymentIntent = json.decode(response.body);
      final clientSecret = paymentIntent['client_secret'];
      return clientSecret as String;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      if (e is StripeException && e.error.code == FailureCode.Canceled) {
        rethrow;
      } else {
        log(e.toString());
      }
    }
  }
}
