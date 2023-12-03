// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
import '../../../utils/constants/app_colors.dart';
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

  List<String> options = [
    'Work',
    'Home',
    'Other',
  ];

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
            SelectAddressType(size: size, w: w, addressNotifier: addressNotifier, options: options),
        
            // ===============
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
          padding: EdgeInsets.only(bottom: size.height * 0.016),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyBlueButton(
                hPadding: w * 0.1,
                text: "Add Address",
                onTap: () {
                  selectedAddres.isNotEmpty
                      ? _addAddressHandler()
                      : showSnakeBar(context, "Please Select an Address First");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectAddressType extends StatelessWidget {
  const SelectAddressType({
    super.key,
    required this.size,
    required this.w,
    required this.addressNotifier,
    required this.options,
  });

  final Size size;
  final double w;
  final AddressNotifier addressNotifier;
  final List<String> options;

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

            padding: EdgeInsets.symmetric(horizontal: w / 28),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(w / 30),
              color: const Color.fromARGB(194, 240, 240, 240),
            ),
            child: DropdownButton<String>(
              value: addressNotifier.addAddressType,
              borderRadius: BorderRadius.circular(w / 28),
              isExpanded: true,
              underline: SizedBox(),
              items: options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (String? newValue) {
                addressNotifier.setAddAddressType(
                    addAddressType: newValue!);
              },
              hint: MyTextPoppines(
                text: "Not Selected",
                color: AppColors.black,
                fontSize: size.height * FontSize.fifteen,
                // fontSize: w / 34,
                fontWeight: FontWeight.w500,
              ),
              style: GoogleFonts.poppins(
                color: AppColors.black,
                fontSize: w / 32,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
