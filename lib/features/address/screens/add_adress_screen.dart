// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:new_user_side/features/auth/widgets/my_text_field.dart';
import 'package:new_user_side/provider/notifiers/address_notifier.dart';
import 'package:new_user_side/resources/common/buttons/my_buttons.dart';
import 'package:new_user_side/resources/common/my_app_bar.dart';
import 'package:new_user_side/resources/font_size/font_size.dart';
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
  var addressTypes = [
    "Address Type",
    "work",
    'home',
    'other',
  ];
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

    // if(addressController.text.length > 3 && addressController.text.length < 10)
    notifier.getAddressSuggestions(addressController.text);
  }

  _addAddressHandler() async {
    final notifier = context.read<AddressNotifier>();
    await notifier.addAddress(context: context, placeId: _placeId);
  }

  @override
  Widget build(BuildContext context) {
    final addressNotifier = context.watch<AddressNotifier>();
    final w = MediaQuery.of(context).size.width;
    final size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: addressNotifier.loading,
      child: Scaffold(
        appBar: MyAppBar(
          text: "Add Address",
          onBack: () {
            Navigator.pop(context);
            addressNotifier.onBackClick();
          },
        ),
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
                  
                  final address =
                      addressNotifier.addressList[index]["description"];
                  return ListAddressTile(
                    onTap: () async {
                      addressController.text = address;
                      selectedAddres = address;
                      _placeId = addressNotifier.addressList[index]["place_id"];
                    },
                    address: address,
                  );
                },
              ),
            ),
          ],
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.only(bottom: w * 0.01, left: w * 0.01, right:  w * 0.01),
          child: addressNotifier.addAddressType.isNotEmpty &&
                  addressNotifier.addAddressType != "Address Type"
              ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // SizedBox(), 
                  Container(

                    child: Text("  Type : ${addressNotifier.addAddressType}", style: TextStyle(
                      fontSize: size.height * FontSize.fourteen, 
                      // fontSize: size.height * FontSize.fourteen, 
                    ),),
                  ), 
                  MyBlueButton(
                      hPadding: w * 0.1,
                      text: "Add Address",
                      onTap: () {
                        selectedAddres.isNotEmpty
                            ? _addAddressHandler()
                            : showSnakeBar(
                                context, "Please Select an Address First");
                      },
                    ),
                ],
              )
              : Container(
                  height: 70,
                  // width: 160,
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.w,
                  ).copyWith(bottom: 20),
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(w / 28),
                    hint: Text("Address Type"),
                    elevation: 0,
                    isExpanded: true,
                    value: "Address Type",
                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: addressTypes.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (value) {
                      addressNotifier.setAddAddressType(addAddressType: value!);
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
