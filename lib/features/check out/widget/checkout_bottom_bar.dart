// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/provider/notifiers/check_out_notifier.dart';
import 'package:new_user_side/resources/common/buttons/my_buttons.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../resources/common/my_text.dart';
import '../../../resources/font_size/font_size.dart';

class CheckOutBottomBar extends StatefulWidget {
  final String totalAmount;
  final String projectName;
  final String bookingId;
  const CheckOutBottomBar({
    Key? key,
    required this.totalAmount,
    required this.projectName,
    required this.bookingId,
  }) : super(key: key);

  @override
  State<CheckOutBottomBar> createState() => _CheckOutBottomSnackBarState();
}

class _CheckOutBottomSnackBarState extends State<CheckOutBottomBar> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final notifier = context.watch<CheckOutNotifier>();
    final size = MediaQuery.of(context).size;
    _checkOutHandler() async {
      final notifier = context.read<CheckOutNotifier>();
      await notifier.checkOut(
        context: context,
        bookingId: widget.bookingId,
      );
    }

    return Container(
      height: 168.h,
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(30, 0, 0, 0),
            offset: const Offset(0, -4),
            blurRadius: 5.r,
            spreadRadius: 2.r,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.r),
                    color: AppColors.buttonBlue.withOpacity(0.12),
                  ),
                  child: MyTextPoppines(
                    text: widget.projectName,
                    height: 1.4,
                    fontSize: size.height * FontSize.twelve,
                    color: AppColors.buttonBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                10.vs,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyTextPoppines(
                      text: "  You have to pay :",
                      fontSize: size.height * FontSize.fourteen,
                      fontWeight: FontWeight.w600,
                    ),
                    MyTextPoppines(
                      text:
                          // "\$ ${widget.totalAmount}",
                          "\$${(double.parse(widget.totalAmount) + (double.parse(widget.totalAmount) * 0.13)).toStringAsFixed(2)}",
                      fontSize: size.height * FontSize.fourteen,
                      fontWeight: FontWeight.w600,
                      color: AppColors.yellow,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(thickness: 2, height: 5.h),
          10.vs,
          MyBlueButton(
            isWaiting: notifier.loading,
            // vPadding: 1.h,
            hPadding: 100.w,
            text: "Pay Now",
            fontSize: height > 800 ? 13.sp : size.height * FontSize.sixteen,
            onTap: () => _checkOutHandler(),
          )
        ],
      ),
    );
  }
}
