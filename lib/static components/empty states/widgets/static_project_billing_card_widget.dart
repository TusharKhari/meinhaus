

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../resources/common/my_text.dart';
import '../../../utils/constants/app_colors.dart';

class StaticProjectBillingCard extends StatelessWidget {
  const StaticProjectBillingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final height = context.screenHeight;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          width: 1.0,
          color: AppColors.yellow,
        ),
        color: const Color(0xFFFEF8EE),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          8.vspacing(context),
          _buildShowPrice(
            context: context,
           text: "Subtotal : \$00",
          // text: "Subtotal : \$${pBill.totalCost}",
            fontWeight: FontWeight.w600,
          ),
          4.vspacing(context),
          _buildShowPrice(
            context: context,
           text: "HST 13%  = \$00",
          // text: "HST 13% (830275681RRT0001) = \$", hstAmountToPay
       
          ),
          4.vspacing(context),
          _buildShowPrice(
            context: context,
            // text: "Total : \$${pBill.totalCost}",
             text: "Total : \$00",
            fontWeight: FontWeight.w600,
          ),
          2.vspacing(context),
          Divider(
            thickness: 1.2,
            color: AppColors.yellow.withOpacity(0.35),
          ),
          2.vspacing(context),
          _buildShowPrice(
            context: context,
           text: "Deposit for project Booking = \$00",
      //  text: "Deposit for project Booking = \$",

          ),
          4.vspacing(context),
          _buildShowPrice(
            context: context,
            // text: "HST 13% (830275681RRT0001) = \$${pBill.hstForDepositAmount}",
            text: "HST 13%  = \$00",
          ),
          5.vspacing(context),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20.r),
                bottomLeft: Radius.circular(20.r),
              ),
              color: AppColors.black,
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: MyTextPoppines(
                // text: "Total : \$${pBill.totalDepositAmount}",
               text: "Total : \$00",

                fontSize: height / 60,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildShowPrice({
    required BuildContext context,
    required String text,
    FontWeight? fontWeight = FontWeight.w500,
  }) {
    return Padding(
      padding: EdgeInsets.only(right: 20.w),
      child: MyTextPoppines(
        text: text,
        fontSize: context.screenHeight / 60,
        fontWeight: fontWeight,
      ),
    );
  }
}