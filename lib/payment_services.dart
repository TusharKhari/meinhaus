import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:new_user_side/local/user_prefrences.dart';
import 'package:new_user_side/res/common/my_snake_bar.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

class MakePayment {
  Map<String, dynamic>? paymentIntent;
  Future<bool> makePayment({
    required BuildContext context,
    required String bookingId,
  }) async {
    try {
      paymentIntent = await createPaymentIntent(bookingId);
      final clientSecret = (paymentIntent!['payment_intent']['client_secret']);
      final customerId = (paymentIntent!['payment_intent']['customer']);
      final ephemeralKey = (paymentIntent!['ephemeralKey']['secret']);
      // final setupintent = await Stripe.instance.confirmSetupIntent(
      //   paymentIntentClientSecret: clientSecret,
      //   params: PaymentMethodParams.card(
      //     paymentMethodData: PaymentMethodData(),
      //   ),
      // );
      // // Check the status of the returned SetupIntent
      // if (setupintent.status.toLowerCase() == 'succeeded') {
      //   return setupintent.paymentMethodId;
      // }
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: clientSecret,
              customerId: customerId,
              customerEphemeralKeySecret: ephemeralKey,
              merchantDisplayName: 'Mein Haus',
            ),
          )
          .then((value) {});
      final res = await displayPaymentSheet(context);
      return res;
    } catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }

  createPaymentIntent(String bookingId) async {
    final headers = await UserPrefrences().getHeader();
    try {
      var response = await http.get(
        Uri.parse('https://meinhaus.ca/api/book-project?booking_id=$bookingId'),
        headers: headers,
      );
      ("Status Code at intentcreation : ${response.statusCode}")
          .log("Create Payment Intent");
      if (response.statusCode == 200) {
        print("Intent Create");
        var data = json.decode(response.body);
        print(data['data']['payment_intent']['client_secret']);
        print(data['data']['payment_intent']['customer']);
        print(data['data']['ephemeralKey']['secret']);
        return data['data'];
      }
    } catch (err) {
      print("error charging user : $err");
      throw Exception(err.toString());
    }
  }

  Future<bool> displayPaymentSheet(BuildContext context) async {
    late bool isValueTrue;
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        print("payment done");
        paymentIntent = null;
        isValueTrue = true;
      }).onError((error, stackTrace) {
        showSnakeBarr(context, "Transcation Declined By User", BarState.Info);
        print("onError in payment sheet ->>> $error");
        isValueTrue = false;
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
      isValueTrue = false;
    } catch (e) {
      print('Error Caught in payment sheet ->>> $e');
      isValueTrue = false;
    }
    return isValueTrue;
  }
}
