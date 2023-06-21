// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/provider/notifiers/auth_notifier.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

import '../../../utils/sizer.dart';

class OtpValidateScreen extends StatefulWidget {
  static const String routeName = '/otp';
  const OtpValidateScreen({
    Key? key,
    required this.email,
  }) : super(key: key);
  final String email;

  @override
  State<OtpValidateScreen> createState() => _OtpValidateScreenState();
}

class _OtpValidateScreenState extends State<OtpValidateScreen> {
  bool isOtpEnterd = false;
  bool isWaiting = false;
  late String otp;

  // Future<void> verifyOTP(String OTP) async {
  //   setState(() {
  //     isWaiting = true;
  //   });
  //   await authServices.verifyOtp(
  //     context: context,
  //     email: widget.email,
  //     otp: OTP,
  //   );
  //   setState(() {
  //     isWaiting = false;
  //   });
  // }

  Future _verifyEmailHandler(String OTP) async {
    final notifer = context.read<AuthNotifier>();
    final body = {"email": widget.email, "otp": OTP};
    await notifer.verifyEmail(body: body, context: context);
  }

  Color buttonColor = AppColors.buttonBlue.withOpacity(0.0);
  @override
  Widget build(BuildContext context) {
    final notifer = context.watch<AuthNotifier>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.vs,
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          width: 1.5,
                          color: AppColors.grey.withOpacity(0.4),
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.black,
                        size: context.screenHeight / MyFontSize.font16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 100.w, top: 10.h),
                    child: SizedBox(
                      width: 70.w,
                      height: 60.h,
                      child: Image.asset(
                        "assets/logo/home.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Column(
                  children: [
                    20.vs,
                    Align(
                      alignment: Alignment.center,
                      child: MyTextPoppines(
                        text: "Let's Verify your email..!",
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    30.vs,
                    MyTextPoppines(
                      text:
                          "We’ve sent an email with an activation code to your email ${widget.email}",
                      fontSize: 14.sp,
                      color: AppColors.black.withOpacity(0.7),
                      textAlign: TextAlign.center,
                    ),
                    30.vs,
                    OTPTextField(
                      length: 4,
                      width: MediaQuery.of(context).size.width,
                      fieldWidth: 60.w,
                      otpFieldStyle: OtpFieldStyle(
                        focusBorderColor: AppColors.black,
                      ),
                      outlineBorderRadius: 12.r,
                      fieldStyle: FieldStyle.box,
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      contentPadding: EdgeInsets.symmetric(vertical: 15.h),
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: (value) {
                        setState(() {
                          buttonColor = AppColors.buttonBlue.withOpacity(
                              (value.isNotEmpty && value.length <= 4)
                                  ? 0.2 * value.length
                                  : 1.0);
                        });
                      },
                      onCompleted: (value) {
                        setState(() => isOtpEnterd = true);
                        setState(() => otp = value);
                        print("otp set" + otp);
                        print("Completed " + value);
                      },
                    ),
                    30.vs,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyTextPoppines(
                          text: "I didn't receive a code",
                          fontSize: 15.sp,
                          color: AppColors.black.withOpacity(0.6),
                        ),
                        5.hs,
                        MyTextPoppines(
                          text: "Resend",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    ),
                    30.vs,
                    const Divider(thickness: 1.5),
                    MediaQuery.of(context).viewInsets.bottom > 0
                        ? 30.vs
                        : 250.vs,
                    InkWell(
                      onTap: () {
                        isOtpEnterd ? _verifyEmailHandler(otp) : null;
                      },
                      child: Container(
                        width: 180.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.r),
                          color: buttonColor,
                          boxShadow: [
                            isOtpEnterd
                                ? const BoxShadow(
                                    color: Color(0x3f000000),
                                    offset: Offset(0, 4),
                                    blurRadius: 4,
                                  )
                                : const BoxShadow(color: Colors.transparent)
                          ],
                        ),
                        child: Center(
                          child: notifer.loading
                              ? CircularProgressIndicator(
                                  color: AppColors.white,
                                )
                              : MyTextPoppines(
                                  text: "Verify OTP",
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.sp,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
