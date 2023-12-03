// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_user_side/features/auth/widgets/my_text_field.dart';
import 'package:new_user_side/resources/common/buttons/my_buttons.dart';
import 'package:new_user_side/resources/common/my_app_bar.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../../data/network/network_api_servcies.dart';
import '../../../provider/notifiers/address_notifier.dart';
import '../../../resources/common/my_snake_bar.dart';
import '../../../resources/common/my_text.dart';
import '../../../resources/font_size/font_size.dart';
import '../../../utils/constants/app_colors.dart';
import '../widget/address_list_tile.dart';

class UpdateAdressScreen extends StatefulWidget {
  static const String routeName = '/update-address';
  const UpdateAdressScreen({
    Key? key,
    required this.perAddress,
    required this.addressId,
    required this.addType,
  }) : super(key: key);
  final String perAddress;
  final String addressId;
  final String addType;
  @override
  State<UpdateAdressScreen> createState() => _UpdateAdressScreenState();
}

class _UpdateAdressScreenState extends State<UpdateAdressScreen> {
  TextEditingController addressController = TextEditingController();

  String selectedAddres = '';
  String placeId = "";
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
    await notifier.updateAddress(
        context: context, placeId: placeId, addressId: addressId);
  }

  Future _deleteAddressHandler() async {
    final notifier = context.read<AddressNotifier>();
    final MapSS body = {"id": widget.addressId};
    await notifier.deleteAddress(context: context, body: body);
  }

  var addressTypes = [
    "work",
    'home',
    'other',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final addressNotifier = context.watch<AddressNotifier>();
    return ModalProgressHUD(
      inAsyncCall: addressNotifier.loading,
      child: Scaffold(
        appBar: MyAppBar(
          text: "Edit Address",
          onBack: () {
            Navigator.pop(context);
            addressNotifier.onBackClick();
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UpdateAddressSelectedAddressType(
              addressNotifier: addressNotifier,
              options: addressTypes,
              size: size,
              addressType: widget.addType,
            ),
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
                    },
                    address: address,
                  );
                },
              ),
            ),
          ],
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.only(bottom: size.height * 0.02),
          // padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyBlueButton(
                hPadding: w * 0.1,
                text: "Delete",
                onTap: () => _deleteAddressHandler(),
              ), 
              MyBlueButton(
                hPadding: 60.w,
                text: "Update", 
                onTap: () {
                  selectedAddres.isNotEmpty
                      ? _updateAddressHandler(addressId: widget.addressId)
                      : showSnakeBar(context, "Select an address please");
                },
              ), 
            ],
          ),
        ),
      ),
    );
  }
}

class UpdateAddressSelectedAddressType extends StatelessWidget {
  const UpdateAddressSelectedAddressType({
    super.key,
    required this.size,
    required this.addressNotifier,
    required this.options,
    required this.addressType,
  });

  final Size size;

  final AddressNotifier addressNotifier;
  final List<String> options;
  final String addressType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 25.w,
        vertical: 10.h,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTextPoppines(
            text: "Select address type",
            fontWeight: FontWeight.w600,
            fontSize: size.height * FontSize.sixteen,
          ),
          5.vspacing(context),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: size.width / 28),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size.width / 30),
              color: const Color.fromARGB(194, 240, 240, 240),
            ),
            child: DropdownButton<String>(
              value: addressNotifier.addAddressType,
              borderRadius: BorderRadius.circular(size.width / 28),
              isExpanded: true,
              underline: SizedBox(),
              items: options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (String? newValue) {
                addressNotifier.setUpdateAddressType(
                    updateAddressType: newValue!);
              },
              hint: MyTextPoppines(
                text: addressType,
                // text: "Not Selected",
                color: AppColors.black,
                fontSize: size.height * FontSize.fifteen,
                // fontSize: w / 34,
                fontWeight: FontWeight.w500,
              ),
              style: GoogleFonts.poppins(
                color: AppColors.black,
                fontSize: size.width / 32,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
