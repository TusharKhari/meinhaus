// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/data/network/network_api_servcies.dart';
import 'package:new_user_side/provider/notifiers/auth_notifier.dart';
import 'package:new_user_side/resources/common/buttons/my_buttons.dart';
import 'package:new_user_side/resources/common/my_app_bar.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../resources/font_size/font_size.dart';
import '../../../utils/constants/app_colors.dart';
import '../widgets/phone_number_textfield.dart';

class AddPhoneNumberScreen extends StatefulWidget {
  final String userId;

  const AddPhoneNumberScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<AddPhoneNumberScreen> createState() => _AddPhoneNumberScreenState();
}

class _AddPhoneNumberScreenState extends State<AddPhoneNumberScreen> {
  TextEditingController _phoneController = TextEditingController();

  // Adding phone number using user_id
  Future<void> addPhoneNo() async {
    final notifier = context.read<AuthNotifier>();
    final phoneNumber = _phoneController.text.replaceAll('-', "");
    MapSS body = {
      "user_id": widget.userId,
      "phone": phoneNumber,
    };
    await notifier.addPhoneNo(body: body, context: context);
  }

  @override
  Widget build(BuildContext context) {
      final authNotifier = context.watch<AuthNotifier>();
    final h = context.screenHeight;
    final w = context.screenWidth;
     final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: MyAppBar(text: "Add Mobile No"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w / 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h / 30),
                  MyTextPoppines(
                    text: "Please Enter the registered number to continue.",
                    fontSize: size.height * FontSize.sixteen,
                    // fontSize: w / 19,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: h / 40),
                  // Phone number textfield
                  PhoneNumberTextFeild(controller: _phoneController),
                  SizedBox(height: h / 80),
                  Align(
                    alignment: Alignment.centerRight,
                    child: MyBlueButton(
                      isWaiting: authNotifier.loading,
                      hPadding: w / 18,
                      vPadding: h / 80,
                      text: "Send OTP",
                      onTap: () => addPhoneNo(),
                      fontSize: 18.sp,
                      // fontSize: w / 32,
                    ),
                  ),
                  SizedBox(height: h / 30), 
                ],
              ),
            ), 
          ],
        ),
      ),
    );
  }
}
