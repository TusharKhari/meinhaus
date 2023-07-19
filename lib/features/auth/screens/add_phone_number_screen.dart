// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import 'package:new_user_side/res/common/my_app_bar.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/extensions/validator.dart';

class AddPhoneNumberScreen extends StatefulWidget {
  const AddPhoneNumberScreen({super.key});

  @override
  State<AddPhoneNumberScreen> createState() => _AddPhoneNumberScreenState();
}

class _AddPhoneNumberScreenState extends State<AddPhoneNumberScreen> {
  TextEditingController _phoneController = TextEditingController();
  bool isOtpEnterd = false;
  late String otp;
  // Initial time for resending otp
  int startTime = 60;
  // Boolen for showing the resend button
  bool showResendButton = false;
  // Timer for otp

  Color buttonColor = AppColors.buttonBlue.withOpacity(0.0);
  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Scaffold(
      appBar: MyAppBar(text: "Add Mobile No"),
      body: Column(
        children: [
          MyTextPoppines(
            text: "Please Enter the registered number to continue.",
            fontSize: w / 20,
            fontWeight: FontWeight.w500,
          ),
          // Phone number textfield
          PhoneNumberTextFeild(controller: _phoneController),
          Align(
            alignment: Alignment.centerRight,
            child: MyTextPoppines(
              text: "Send OTP",
              fontSize: w / 20,
              fontWeight: FontWeight.w600,
              color: AppColors.buttonBlue,
            ),
          ),

          SizedBox(height: h / 25),
          // OTP TEXT FIELD
          OTPTextField(
            length: 6,
            width: w,
            fieldWidth: w / 8,
            outlineBorderRadius: w / 28,
            fieldStyle: FieldStyle.box,
            textFieldAlignment: MainAxisAlignment.spaceAround,
            keyboardType: TextInputType.number,
            contentPadding: EdgeInsets.symmetric(vertical: h / 75),
            style: TextStyle(
              fontSize: w / 20,
              fontWeight: FontWeight.bold,
            ),
            otpFieldStyle: OtpFieldStyle(
              focusBorderColor: AppColors.black,
            ),
            onChanged: (value) {
              setState(() {
                buttonColor = AppColors.buttonBlue.withOpacity(
                  (value.isNotEmpty && value.length <= 6)
                      ? 0.2 * value.length
                      : 1.0,
                );
              });
            },
            onCompleted: (value) {
              setState(() => isOtpEnterd = true);
              setState(() => otp = value);
              print("otp set" + otp);
              print("Completed " + value);
            },
          ),
          SizedBox(height: h / 60),
          InkWell(
            onTap: () {},
            child: Container(
              width: w / 2,
              height: h / 15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(w / 8),
                color: buttonColor,
              ),
              child: Center(
                child: true
                    ? LoadingAnimationWidget.inkDrop(
                        color: AppColors.white,
                        size: w / 26,
                      )
                    : MyTextPoppines(
                        text: "Verify OTP",
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: w / 22,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class PhoneNumberTextFeild extends StatelessWidget {
  final TextEditingController controller;
  const PhoneNumberTextFeild({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.white,
            border: Border.all(
              color: AppColors.black.withOpacity(0.15),
              width: 1.5,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: w / 25,
            vertical: h / 50,
          ),
          child: MyTextPoppines(
            text: "+1",
            fontSize: w / 25,
          ),
        ),
        SizedBox(width: w / 40),
        Expanded(
          child: _TextField(
            controller: controller,
            hintText: "XXXXXXXXX",
            validator: Validator().validateContactNo,
            onChange: (value) {
              final fv = _formatPhoneNumber(value);
              if (fv != controller.text) {
                controller.value = TextEditingValue(
                  text: fv,
                  selection: TextSelection.collapsed(
                    offset: fv.length,
                  ),
                );
              }
            },
            inputFormatter: [
              LengthLimitingTextInputFormatter(12),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
      ],
    );
  }
}

// Contact number formatter
String _formatPhoneNumber(String value) {
  value = value.replaceAll('-', ''); // Remove existing hyphens
  final buffer = StringBuffer();
  for (int i = 0; i < value.length; i++) {
    if (i == 3 || i == 6) {
      buffer.write('-');
    }
    buffer.write(value[i]);
  }
  return buffer.toString();
}

// Reuseable text field
class _TextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChange;
  final List<TextInputFormatter>? inputFormatter;
  final String hintText;
  final String? Function(String?)? validator;
  const _TextField({
    Key? key,
    required this.controller,
    this.onChange,
    this.inputFormatter,
    required this.hintText,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(w / 26),
              borderSide: BorderSide(
                color: AppColors.black.withOpacity(0.15),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(w / 26),
              borderSide: BorderSide(
                color: AppColors.black.withOpacity(0.15),
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(w / 26),
              borderSide: BorderSide(
                color: Colors.red.shade200,
                width: 1.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(w / 26),
              borderSide: BorderSide(
                color: Colors.red.shade200,
                width: 1.5,
              ),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: w / 26,
              color: AppColors.grey.withOpacity(0.5),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: w / 20, vertical: h / 42),
          ),
          validator: validator,
          onChanged: onChange,
          inputFormatters: inputFormatter,
        ),
      ],
    );
  }
}
