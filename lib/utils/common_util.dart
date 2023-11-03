// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

// ignore: avoid_classes_with_only_static_members
class CommonUtil {
  static const String apiUrl = 'http://192.168.1.100:4242';
  static const String stripeUserCreate = '/add/user';
  static const String checkOut = '/checkout';

  ///
  static Future<http.Response> backendCall(User user, String endPoint) async {
    final token = await user.getIdToken();
    return http.post(
      Uri.parse('$apiUrl$endPoint'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  ///
  static Future<String> checkoutFlow(User user) async {
    var error = '';

    try {
      final response = await backendCall(user, checkOut);
      final json = jsonDecode(response.body);

      final parameters = SetupPaymentSheetParameters(
        customerId: json['customer'],
        customerEphemeralKeySecret: json['ephemeralKey'],
        paymentIntentClientSecret: json['paymentIntent'],
        merchantDisplayName: 'Shoppers',
      );

      await Stripe.instance.initPaymentSheet(paymentSheetParameters: parameters);

      await Future.delayed(const Duration(seconds: 1));

      await Stripe.instance.presentPaymentSheet();
    } on StripeException catch (e) {
      log('error!! ${e.error.message}');

      error = e.error.message.toString();
      // ignore: avoid_catches_without_on_clauses
    } catch (e, stackTrace) {
      log('error!!', stackTrace: stackTrace, error: e);

      error = 'error!!';
    }

    return error;
  }

  ///
  static void showAlert(BuildContext context, String heading, String body) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(heading),
        content: Text(body),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'ok');
            },
            child: const Text('ok'),
          ),
        ],
      ),
    );
  }
}
