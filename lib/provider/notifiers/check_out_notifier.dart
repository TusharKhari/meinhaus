import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:new_user_side/provider/notifiers/estimate_notifier.dart';
import 'package:new_user_side/repository/check_out_repo.dart';
import 'package:new_user_side/resources/common/my_snake_bar.dart';
import 'package:provider/provider.dart';

import '../../data/network/payment/payment_services.dart';
import '../../features/home/screens/home_screen.dart';

class CheckOutNotifier extends ChangeNotifier {
  CheckOutRepository repository = CheckOutRepository();
  int _index = 0;
  bool _loading = false;

  bool get loading => _loading;
  int get index => _index;

  void setLoadingState(
    bool state,
  ) {
    _loading = state;
    notifyListeners();
  }

  void selectCard(int currentIndex) {
    _index = currentIndex;
    notifyListeners();
  }

  Future<void> checkOut({
    required BuildContext context,
    required String bookingId,
  }) async {
    // Map<String, dynamic> intent =
    //  {
    //   "response_code": 200,
    //   "response_message": "Checkout Data",
    //   "data": {
    //     "project_title": "tap cover",
    //     "amount": {
    //       "amount": "101.69999999999999",
    //       "other": "0",
    //       "discount": "0"
    //     },
    //     "payment_intent": {
    //       "id": "pi_3OflRVJ5SREt5Pwv0sMsITlt",
    //       "object": "payment_intent",
    //       "amount": "10170",
    //       "amount_capturable": "0",
    //       "amount_details": {"tip": []},
    //       "amount_received": "0",
    //       "application": null,
    //       "application_fee_amount": null,
    //       "automatic_payment_methods": {
    //         "allow_redirects": "always",
    //         "enabled": true
    //       },
    //       "canceled_at": null,
    //       "cancellation_reason": null,
    //       "capture_method": "automatic",
    //       "charges": {
    //         "object": "list",
    //         "data": [],
    //         "has_more": false,
    //         "total_count": 0,
    //         "url": "/v1/charges?payment_intent=pi_3OflRVJ5SREt5Pwv0sMsITlt"
    //       },
    //       "client_secret":
    //           "pi_3OflRVJ5SREt5Pwv0sMsITlt_secret_25dpwdEdLOdQiHqTphFJPImjK",
    //       "confirmation_method": "automatic",
    //       "created": 1706975265,
    //       "currency": "cad",
    //       "customer": "cus_P8FLDvlmrFMU3g",
    //       "description": null,
    //       "invoice": null,
    //       "last_payment_error": null,
    //       "latest_charge": null,
    //       "livemode": false,
    //       "metadata": [],
    //       "next_action": null,
    //       "on_behalf_of": null,
    //       "payment_method": null,
    //       "payment_method_configuration_details": {
    //         "id": "pmc_1KZdCDJ5SREt5PwvUpmga50k",
    //         "parent": null
    //       },
    //       "payment_method_options": {
    //         "card": {
    //           "installments": null,
    //           "mandate_options": null,
    //           "network": null,
    //           "request_three_d_secure": "automatic"
    //         }
    //       },
    //       "payment_method_types": ["card"],
    //       "processing": null,
    //       "receipt_email": null,
    //       "review": null,
    //       "setup_future_usage": "off_session",
    //       "shipping": null,
    //       "source": null,
    //       "statement_descriptor": null,
    //       "statement_descriptor_suffix": null,
    //       "status": "requires_payment_method",
    //       "transfer_data": null,
    //       "transfer_group": null
    //     },
    //     "ephemeralKey": {
    //       "id": "ephkey_1OflRVJ5SREt5PwvgEGi1q69",
    //       "object": "ephemeral_key",
    //       "associated_objects": [
    //         {"id": "cus_P8FLDvlmrFMU3g", "type": "customer"}
    //       ],
    //       "created": 1706975265,
    //       "expires": 1706978865,
    //       "livemode": false,
    //       "secret":
    //           "ek_test_YWNjdF8xSDRUaGNKNVNSRXQ1UHd2LEhYMlBvWGY5ZWpQOVJmVHBBMGpsWkFJblZVc2RnRVE_00QRzy0wpS"
    //     }
    //   }
    // };
    // (intent["dataa"]?["payment_intent"]?["payment_method_configuration_details"]?
    //         ["id"]?? "na")
    //     .toString()
    //     .log("method id");
    // (intent["data"]["payment_intent"]["id"]).toString().log("p id");

    final onGoingProjects = context.read<EstimateNotifier>();
    setLoadingState(true);
    // Map<String, String> data = {"booking_id": bookingId};
    Map<String, dynamic>? res = await MakePayment()
        .makePayment(context: context, bookingId: bookingId)
        .onError((error, stackTrace) {
      // print("Error in Check out notifier :: $error\n $stackTrace");
      setLoadingState(false);
      return null;
    });
    if (res != null) {
      setLoadingState(true);
      Map<String, String> checkOutData = {
        "booking_id": bookingId,
        "payment_method_id": res["payment_intent"]
                ?["payment_method_configuration_details"]?["id"] ??
            null,
        "transaction_id": res["payment_intent"]?["id"] ?? null
      };
      await repository.checkOut(checkOutData).then((response) {
        showSnakeBarr(
          context,
          //  "Your project has been booked successfully",
          "Your payment is done",
          SnackBarState.Success,
        );
        onGoingProjects.getOngoingProjects(context);
        // Get.to(() => HomeScreen());
        Navigator.pop(context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => HomeScreen(),
            ));
        setLoadingState(false);
      }).onError((error, stackTrace) {
        // print("Error in Check out notifier :: $error\n $stackTrace");
        setLoadingState(false);
      });
    }
  }
}
