// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:new_user_side/resources/font_size/font_size.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../features/additional work/widget/icon_button_with_text.dart';
import '../../../resources/common/my_text.dart';
import '../../dialogs/static_screens_dialog.dart';

class OngoingJobsButtonsPanelStatic extends StatelessWidget {
  const OngoingJobsButtonsPanelStatic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final h = size.height;
    final w = size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 20.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ============
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Customer Support Button
              Expanded(
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return StaticScreensDialog(
                              subtitle:
                                  "This is the customer support option. Select this anytime you need assistance and create a ticket so our team of experts can get right on it!",
                            );
                          },
                        );
                      },
                      child: Container(
                        //  width: w / 2.15,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAEAEA),
                          borderRadius: BorderRadius.circular(w / 12),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 10.h,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/project_detail/customer_support.svg",
                              height: h * 0.02,
                            ),
                            SizedBox(width: w / 40),
                            MyTextPoppines(
                              text: "Customer Support",
                              fontSize: size.height * FontSize.fourteen,
                              // fontSize: size.height * FontSize.fourteen,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // WWhen support is active we will show a active status
                  ],
                ),
              ),
              // Spacer(),
              SizedBox(
                width: 10.w,
              ),
              // Project Notes Button
              Expanded(
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return StaticScreensDialog(
                          subtitle:
                              "This is a note pad for you to save any relevant notes for yourself & your pro as well.",
                        );
                      },
                    );
                  },
                  child: Container(
                    // width: double.maxFinite,
                    // height: h / 16,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8EC),
                      borderRadius: BorderRadius.circular(w / 12),
                    ),
                    padding: EdgeInsets.symmetric(
                      // horizontal: w / 35,
                      vertical: 10.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/project_detail/project_notes.svg",
                          height: h * 0.02,
                        ),
                        SizedBox(width: w / 40),
                        MyTextPoppines(
                          text: "Project Notes",
                          fontSize: size.height * FontSize.fourteen,
                          fontWeight: FontWeight.w600,
                          color: AppColors.yellow,
                          //
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          15.vs,
          // Message pro and Request additional work

          _buildIconButtonWithText(
              firstButtonText: "Message pro",
              firstButtonTextColor: AppColors.buttonBlue,
              firstButtonImgUrl: "assets/project_detail/message_pro.svg",
              firstButtonColor: const Color(0xFFE8F4FF),
              firstButtonOnTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return StaticScreensDialog(
                      subtitle:
                          "Here you can instant message your project Pro. We can access these conversations as required to provide you the best customer service experience!",
                    );
                  },
                );
              },
              secondButtonext: "Invoice",
              // "Invoice($invoicePaidOrPay)",
              secondtButtonTextColor: const Color(0xFF934600),
              // secondButtonImgUrl: "assets/project_detail/work_details.svg",
              secondButtonImgUrl: "assets/project_detail/invoice 1.svg",
              secondButtonColor: const Color(0xFF934600).withOpacity(0.12),
              secondButtonOnTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return StaticScreensDialog(
                      subtitle:
                          "Here you can view all of your past, current and remaining payments for your project.",
                    );
                  },
                );
              }),

//
          15.vs,

          InkWell(
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return StaticScreensDialog(
                    subtitle:
                        "Here you can request additional work you may require for an ongoing project.",
                  );
                },
              );
            },
            child: Container(
              // width: context.screenWidth / 3.2,
              decoration: BoxDecoration(
                color: Color(0xFFF7F6E0),
                borderRadius: BorderRadius.circular(30.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/project_detail/work_details.svg"),
                  SizedBox(width: w / 40),
                  MyTextPoppines(
                    text: "Req Additional Work",
                    fontSize: size.height * FontSize.fourteen,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFB9B100),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButtonWithText({
    required String firstButtonText,
    required Color firstButtonTextColor,
    required String firstButtonImgUrl,
    required Color firstButtonColor,
    required VoidCallback firstButtonOnTap,
    required String secondButtonext,
    required Color secondtButtonTextColor,
    required String secondButtonImgUrl,
    required Color secondButtonColor,
    required VoidCallback secondButtonOnTap,
  }) {
    return Row(
      //  mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: IconButtonWithText(
            text: firstButtonText,
            textColor: firstButtonTextColor,
            buttonColor: firstButtonColor,
            iconUrl: firstButtonImgUrl,
            isIcon: false,
            vPadding: 12.h,
            hPadding: 2.w,
            borderRadius: 20.r,
            onTap: firstButtonOnTap,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: IconButtonWithText(
            text: secondButtonext,
            textColor: secondtButtonTextColor,
            buttonColor: secondButtonColor,
            iconUrl: secondButtonImgUrl,
            isIcon: false,
            vPadding: 12.h,
            hPadding: 15.w,
            borderRadius: 20.r,
            onTap: secondButtonOnTap,
          ),
        ),
      ],
    );
  }
}
