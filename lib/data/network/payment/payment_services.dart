import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:new_user_side/local%20db/user_prefrences.dart';
import 'package:new_user_side/provider/notifiers/check_out_notifier.dart';
import 'package:new_user_side/resources/common/my_snake_bar.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../resources/common/api_url/api_urls.dart';
import '../../../utils/constants/constant.dart';

class MakePayment {
  Map<String, dynamic>? paymentIntent;
  Future<Map<String, dynamic>?> makePayment({
    required BuildContext context,
    required String bookingId,
  }) async {
    try {
      paymentIntent = await createPaymentIntent(bookingId);
      final clientSecret = (paymentIntent!['payment_intent']['client_secret']);
      final customerId = (paymentIntent!['payment_intent']['customer']);
      final ephemeralKey = (paymentIntent!['ephemeralKey']['secret']);
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          customerId: customerId,
          customerEphemeralKeySecret: ephemeralKey,
          merchantDisplayName: 'Mein Haus',
        ),
      );
      final res = await displayPaymentSheet(context);
      if (res == true) {
        return paymentIntent;
      } else {
        return null;
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  createPaymentIntent(String bookingId) async {
    final headers = await UserPrefrences().getHeader();
    try {
      var response = await http.get(
        Uri.parse('${ApiUrls.createIntent}$bookingId'),
        headers: headers,
      );
      if (isTest)
        ("Status at Intent Creation : ${response.statusCode}")
            .log("Create Payment Intent");
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (kDebugMode) {
          // help dev to see the output
          // print(data['data']['payment_intent']['client_secret']);
          // print(data['data']['payment_intent']['customer']);
          // print(data['data']['ephemeralKey']['secret']);
        }
        // print("payment intent ${data}");
       if(isTest) data.toString().log("payment intent");
        return data['data'];
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<bool> displayPaymentSheet(BuildContext context) async {
    final notifier = context.read<CheckOutNotifier>();
    late bool isValueTrue;
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        print(value?.toJson() ?? "null");
         isValueTrue = true;
      }).onError((error, stackTrace) {
        notifier.setLoadingState(false);
        showSnakeBarr(context, "Transaction Declined", SnackBarState.Info);
        isValueTrue = false;
        throw Exception(
            " display payment sheet error  $error  stackTrace---> $stackTrace");
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
     if(isTest) print('Error Caught in payment sheet ->>> $e');
      isValueTrue = false;
    }
    return isValueTrue;
  }
}


/*
{response_code: 200, response_message: Checkout Data, 
data: 
{project_title: tap cover, 
amount: {amount: 101.69999999999999, other: 0, discount: 0}, 
payment_intent: {id: pi_3OflRVJ5SREt5Pwv0sMsITlt, object: payment_intent, amount: 10170, amount_capturable: 0,
 amount_details: {tip: []}, amount_received: 0, application: null, application_fee_amount: null,
  automatic_payment_methods: {allow_redirects: always, enabled: true}, canceled_at: null,
   cancellation_reason: null,
    capture_method: automatic, charges: {object: list, data: [],
     has_more: false, total_count: 0, 
     url: /v1/charges?payment_intent=pi_3OflRVJ5SREt5Pwv0sMsITlt},
      client_secret: pi_3OflRVJ5SREt5Pwv0sMsITlt_secret_25dpwdEdLOdQiHqTphFJPImjK,
       confirmation_method: automatic, created: 1706975265, 
       currency: cad, customer: cus_P8FLDvlmrFMU3g, description: null, invoice: null,
        last_payment_error: null, latest_charge: null, livemode: false, metadata: [], 
        next_action: null, on_behalf_of: null, payment_method: null, 
        payment_method_configuration_details: {id: pmc_1KZdCDJ5SREt5PwvUpmga50k, parent: null},
         payment_method_options: {card: {installments: null, mandate_options: null, network: null,
          request_three_d_secure: automatic}}, payment_method_types: [card], processing: null,
           receipt_email: null, review: null, setup_future_usage: off_session, shipping: null, source: null,
            statement_descriptor: null, statement_descriptor_suffix: null, status: requires_payment_method,
             transfer_data: null, transfer_group: null}, ephemeralKey: {id: ephkey_1OflRVJ5SREt5PwvgEGi1q69, 
             object: ephemeral_key, associated_objects: [{id: cus_P8FLDvlmrFMU3g, type: customer}],
              created: 1706975265, expires: 1706978865, livemode: false, 
              secret: ek_test_YWNjdF8xSDRUaGNKNVNSRXQ1UHd2LEhYMlBvWGY5ZWpQOVJmVHBBMGpsWkFJblZVc2RnRVE_00QRzy0wpS}}}
 */