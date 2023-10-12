// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
 import 'package:new_user_side/features/auth/screens/user_details.dart';
import 'package:new_user_side/provider/notifiers/address_notifier.dart';
import 'package:new_user_side/resources/common/buttons/my_buttons.dart';
import 'package:new_user_side/resources/common/my_app_bar.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../resources/common/my_snake_bar.dart';
import '../../../resources/common/my_text.dart';
 import '../widget/address_list_tile.dart';

class AddAddressScreen extends StatefulWidget {
  static const String routeName = '/add-address';
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  TextEditingController addressController = TextEditingController();
  String selectedAddres = '';
  String _placeId = "";
  @override
  void initState() {
    super.initState();
    addressController.addListener(() {
      onChange();
    });
  }

  @override
  void dispose() {
    super.dispose();
    addressController.dispose();
  }

  void onChange() {
    final notifier = context.read<AddressNotifier>();
    notifier.getAddressSuggestions(addressController.text);
  }

  _addAddressHandler() async {
    final notifier = context.read<AddressNotifier>(); 

    // Map<String, dynamic > latLng = await notifier.getLatLngFromPlaceId(placeId: _placeId);
  //   var address2 = await Utils.getAddress(latLng["lat"], latLng["lng"]);
  //  // var address2 = await Utils.getAddress(first.latitude, first.longitude);
  //   var first2 = address2.first;
  //  // print("first2 $first2");
  //   final MapSS addressBody = {
  //     "address": addressController.text,
  //     "longitude": latLng["lat"].toString(),
  //      "latitude": latLng["lng"].toString(), 
  //        'line1': first2.name.toString(),
  //       'line2': first2.street.toString() ,
  //       'city': "${first2.subLocality}, ${first2.locality}",
  //       'state': first2.administrativeArea.toString(),
  //       'country': first2.country.toString(),
  //       'zip': first2.postalCode.toString(),
  //   };
  //  print("body  $body");
    //await notifier.addAddress(context: context, body: addressBody);
    await notifier.addAddress(context: context, placeId: _placeId);
  }

  @override
  Widget build(BuildContext context) {
    final addressNotifier = context.watch<AddressNotifier>();
    return ModalProgressHUD(
      inAsyncCall: addressNotifier.loading,
      child: Scaffold(
        appBar: MyAppBar(text: "Add Address"),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyTextField(
              text: "Add Address",
              controller: addressController,
              hintText: "44 E. West Street Ashland, OH 44805.",
            ),
            Divider(
              thickness: 2,
              color: Color.fromARGB(32, 0, 0, 0),
            ),
            10.vs,
            addressNotifier.addressList.isEmpty
                ? MyTextPoppines(
                    text: "       No Results",
                    fontWeight: FontWeight.w600,
                  )
                : MyTextPoppines(
                    text: "       Suggestions",
                    fontWeight: FontWeight.w600,
                  ),
            10.vs,
            Expanded(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: addressNotifier.addressList.length,
                itemBuilder: (context, index) {
                  // ("place id ${addressNotifier.addressList[index]["place_id"]}").log();
                  final address =  addressNotifier.addressList[index]["description"];
                  return ListAddressTile(
                    onTap: () async{
                      
                      addressController.text = address;
                      selectedAddres = address;
                      _placeId =  addressNotifier.addressList[index]["place_id"];
                  // Map<String, dynamic> mp =   await addressNotifier.getLatLngFromPlaceId(placeId: selectedAddres);
                //   print("add add ${mp["lat"]}");
                    },
                    address: address,
                  );
                },
              ),
            ),
          ],
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.only(left: 40.w, bottom: 10.h),
          child: MyBlueButton(
            hPadding: 110.w,
            text: "Add Address",
            onTap: () {
              selectedAddres.isNotEmpty
                  ? _addAddressHandler()
                  : showSnakeBar(context, "Please Select an Address First");
            },
          ),
        ),
      ),
    );
  }
}
