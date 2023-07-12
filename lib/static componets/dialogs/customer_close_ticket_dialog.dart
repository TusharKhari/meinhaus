import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/features/chat/screen/chatting_screen.dart';
import 'package:new_user_side/features/chat/widgets/customer_bottom_sheet.dart';
import 'package:new_user_side/res/common/buttons/my_buttons.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/static%20componets/dialogs/customer_keep_open_dialog.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

class CustosmerCloseTicketDialog extends StatelessWidget {
  const CustosmerCloseTicketDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Dialog(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Column(
            children: [
              5.vs,
              SizedBox(
                width: 98.w,
                height: 98.h,
                child: Image.asset("assets/icons/question.png"),
              ),
              20.vs,
              SizedBox(
                width: 300.w,
                child: MyTextPoppines(
                  text:
                      "Support is requesting to close the ticket. Are you satisfied ?",
                  fontSize: 16.sp,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                ),
              ),
              20.vs,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const CustomerSupportKeepOpenDialog();
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          border: Border.all(color: AppColors.grey),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 9.h),
                        child: Center(
                          child: MyTextPoppines(
                            text: "Keep Open",
                            fontWeight: FontWeight.w500,
                            fontSize: height > 800 ? 12.sp : 14.sp,
                            color: AppColors.grey,
                          ),
                        ),
                      ),
                    ),
                    Consumer<SupportUserMessagesProvider>(
                      builder: (context, value, child) {
                        return MyBlueButton(
                          hPadding: 15.w,
                          vPadding: height > 700
                              ? 10.h
                              : height > 650
                                  ? 13.h
                                  : 18.h,
                          fontSize: height > 800 ? 12.sp : 14.sp,
                          text: "Accept & Close",
                          onTap: () {
                            Navigator.of(context).pushScreen(
                              ChattingScreen(isChatWithPro: false),
                            );
                            value.conversationEnd();
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
              10.vs,
            ],
          ),
        ),
      ),
    );
  }
}
