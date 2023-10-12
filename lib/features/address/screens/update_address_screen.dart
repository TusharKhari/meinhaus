// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/features/auth/screens/user_details.dart';
import 'package:new_user_side/resources/common/buttons/my_buttons.dart';
import 'package:new_user_side/resources/common/my_app_bar.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../../data/network/network_api_servcies.dart';
import '../../../provider/notifiers/address_notifier.dart';
import '../../../resources/common/my_snake_bar.dart';
import '../../../resources/common/my_text.dart';
 import '../widget/address_list_tile.dart';

class UpdateAdressScreen extends StatefulWidget {
  static const String routeName = '/update-address';
  const UpdateAdressScreen({
    Key? key,
    required this.perAddress,
    required this.addressId,
  }) : super(key: key);
  final String perAddress;
  final String addressId;

  @override
  State<UpdateAdressScreen> createState() => _UpdateAdressScreenState();
}

class _UpdateAdressScreenState extends State<UpdateAdressScreen> {
  TextEditingController addressController = TextEditingController();

  String selectedAddres = '';
  String placeId ="";
  bool isWaiting = false;

  @override
  void initState() {
    super.initState();
    addressController = TextEditingController(text: widget.perAddress);
    addressController.addListener(() => onChange());
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

  Future _updateAddressHandler({required String addressId}) async {
    final notifier = context.read<AddressNotifier>();
    await notifier.updateAddress(context: context,placeId: placeId, addressId:addressId );
  }

  Future _deleteAddressHandler() async {
    final notifier = context.read<AddressNotifier>();
    final MapSS body = {"id": widget.addressId};
    await notifier.deleteAddress(context: context, body: body);
  }

  var addressTypes = [  
    "Address Type" , 
     "Work",    
    'Home', 
    'Other',  
  ]; 

  @override
  Widget build(BuildContext context) {
    final addressNotifier = context.watch<AddressNotifier>();
    return ModalProgressHUD(
      inAsyncCall: addressNotifier.loading,
      child: Scaffold(
        appBar: MyAppBar(text: "Edit Address", onBack: ()  {
          Navigator.pop(context);
          addressNotifier.onBackClick();},),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyTextField(
              text: "Edit Address",
              controller: addressController,
              hintText: "44 E. West Street Ashland, OH 44805.",
              
            ),
            Divider(thickness: 2, color: Color.fromARGB(32, 0, 0, 0)),
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
                    onTap: () {
                      addressController.text = address;
                      selectedAddres = address;
                      placeId = addressNotifier.addressList[index]["place_id"];
                      print("selectedAddres : $selectedAddres");
                    },
                    address: address,
                  );
                },
              ),
            ),
          ],
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyBlueButton(
                hPadding: 60.w,
                text: "Delete",
                onTap: () => _deleteAddressHandler(),
              ),
             

             addressNotifier.addressType.isNotEmpty && addressNotifier.addressType != "Address Type" ?  MyBlueButton(
                hPadding: 60.w,
                text: "Update",
                onTap: () {
                  selectedAddres.isNotEmpty
                      ? _updateAddressHandler(addressId: widget.addressId)
                      : showSnakeBar(context, "Select an address please");
                },
              ) :

              Container(
                height: 70,
                width: 180,
                child: DropdownButton(
                  elevation: 0,
                isExpanded: true,
                  value: "Address Type", 
                // Down Arrow Icon 
                icon: const Icon(Icons.keyboard_arrow_down),
                  items:  addressTypes.map((String items) { 
                     return DropdownMenuItem( 
                     value: items, 
                    child: Text(items), 
                  ); 
                }).toList(), onChanged: (value) { 
                 addressNotifier.setAddressType(addressType: value!); 
                },),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
