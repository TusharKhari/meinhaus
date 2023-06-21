import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../customer support/widget/customer_bottom_sheet.dart';

class ChatWithProScreen extends StatelessWidget {
  static const String routeName = '/chatwithpro';
  const ChatWithProScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.black,
            size: 20.sp,
          ),
        ),
        titleSpacing: 0,
        elevation: 0.0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 18.r,
                ),
                Positioned(
                  right: 0.w,
                  top: 2.h,
                  child: CircleAvatar(
                    radius: 4.r,
                    backgroundColor: AppColors.green,
                  ),
                ),
              ],
            ),
            10.hs,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                5.vs,
                MyTextPoppines(
                  text: "Nate Diaz",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                3.vs,
                Row(
                  children: [
                    MyTextPoppines(
                      text: "  Active now",
                      fontSize: 10.sp,
                      color: AppColors.black.withOpacity(0.4),
                    ),
                    5.hs,
                    CircleAvatar(
                      radius: 4.r,
                      backgroundColor: AppColors.green,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
        actions: [
          Icon(
            CupertinoIcons.ellipsis_vertical,
            color: AppColors.black,
            size: 18.sp,
          ),
          10.hs,
        ],
      ),
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          // Project details
          Container(
            color: AppColors.yellow.withOpacity(0.15),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextPoppines(
                      text: "Furniture Fixing",
                      fontSize: height > 800 ? 12.sp : 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    2.vs,
                    MyTextPoppines(
                      text: "OD-79E9646",
                      fontSize: height > 800 ? 8.sp : 10.sp,
                      color: AppColors.yellow,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                MyTextPoppines(
                  text: "Project Started On : 15/02/2023",
                  fontSize: height > 800 ? 10.sp : 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  120.vs,
                  // No message yet
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(12, 0, 0, 0),
                          offset: const Offset(0, 0),
                          blurRadius: 10.r,
                          spreadRadius: 2.r,
                        ),
                      ],
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
                    child: Column(
                      children: [
                        MyTextPoppines(
                          text: "No Messages yet..!",
                          fontSize: 20.sp,
                          color: AppColors.yellow,
                        ),
                        20.vs,
                        MyTextPoppines(
                          text: "Send a message to \n     chat with Pro..!",
                          fontSize: 16.sp,
                          color: AppColors.black.withOpacity(0.4),
                        ),
                        20.vs,
                        SizedBox(
                          height: 96.h,
                          width: 101.w,
                          child: Image.asset("assets/icons/message.png"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: const CustomerBottomSheet(
        isSupportChat: false,
      ),
    );
  }
}
