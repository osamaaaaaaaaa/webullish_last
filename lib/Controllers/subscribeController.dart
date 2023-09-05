import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:webullish/Services/apiConst.dart';
import 'package:webullish/View/Screens/Auth/register.dart';
import 'package:webullish/View/bottomNavBar.dart';
import 'package:webullish/utils/AppHelper.dart';

import '../Models/UserModel.dart';
import '../Services/apiServices.dart';

class subscribeController extends GetxController {
  User? user;
  subscribeController() {
    getUserProfile();
  }

  getUserProfile() async {
    try {
      await apiServices()
          .getRequestMap(
        url: apiConst.userByID,
      )
          .then((value) {
        if (value.isNotEmpty && value['error'] != null) {
          //AppHelper.errorsnackbar("user:${value['error']}");

          return;
        }

        user = User.fromJson(value['user']);

        update();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> initPaymentSheet(context,
      {required int amount, required String planId}) async {
    if (user == null) {
      Get.to(() => register());
      return;
    }
    try {
      // 1. create payment intent on the server
      final response = await http.post(
          Uri.parse(
              'https://us-central1-webullish-14c86.cloudfunctions.net/stripePaymentIntentRequest'),
          body: {
            'email': user?.email,
            'amount': amount.toString(),
          });

      final jsonResponse = jsonDecode(response.body);
      log(jsonResponse.toString());

      //2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: jsonResponse['paymentIntent'],
          merchantDisplayName: 'Webullish Subscription',
          customerId: jsonResponse['customer'],
          customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
          style: ThemeMode.light,
          allowsDelayedPaymentMethods: true,
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment completed!')),
      );
      addUserSubscribe(planId);
      print('object');
    } catch (e) {
      if (e is StripeException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error from Stripe: ${e.error.localizedMessage}'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  addUserSubscribe(planid) async {
    try {
      apiServices().postRequestMap(
        url: 'api/plan/checkoutPlan',
        body: {'plan_id': planid},
      ).then((value) {
        if (value['error'] != null) {
          AppHelper.errorsnackbar(value['error'].toString());
          return;
        }
      });
      FirebaseMessaging.instance.subscribeToTopic('topic');
      AppHelper.succssessnackbar('');
      Get.off(() => bottomNavBar());
    } catch (e) {
      print(e);
    }
  }

  PayPalPay({required double amount, required String planId}) {
    if (user == null) {
      Get.to(() => register());
      return;
    }
    UsePaypal(
        sandboxMode: false,
        clientId:
            "AYNIZyJHoQbOCvaMBcz0dpujURWL0GOKi2PjCenYLUC4e_LAjyU4ut-N_kA15VdqKqJGNIvubvCpViEi",
        secretKey:
            "EI-9pdBzS-Rjl-ooPbRzhFgtS30dYsGvnole6aJ6YyRXhPkAoIy8bWXsljGTB61yzRil18KS4xVsKgko",
        returnURL: "https://samplesite.com/return",
        cancelURL: "https://samplesite.com/cancel",
        transactions: [
          {
            "amount": {
              "total": '${amount}',
              "currency": "USD",
              "details": {
                "subtotal": '${amount}',
                "shipping": '0',
                "shipping_discount": 0
              }
            },
            "description": "The payment transaction description.",
            // "payment_options": {
            //   "allowed_payment_method":
            //       "INSTANT_FUNDING_SOURCE"
            // },
            "item_list": const {
              "items": [
                {
                  "name": "Webullish subscribe",
                  "quantity": 1,
                  "price": '20.00',
                  "currency": "USD"
                }
              ],

              // shipping address is not required though
              "shipping_address": {
                "recipient_name": "webullish",
                "line1": "united states - Irbid",
                "line2": "",
                "city": "Irbid",
                "country_code": "JO",
                "postal_code": "21121",
                "phone": "+962791560467",
              },
            }
          }
        ],
        note: "Contact us for any questions on your subscribe.",
        onSuccess: (Map params) async {
          // controller.addpremuimuser('monthly');
          addUserSubscribe(planId);
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
