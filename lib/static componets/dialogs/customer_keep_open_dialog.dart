import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/res/common/buttons/my_buttons.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../features/auth/screens/user_details.dart';
import '../../features/chat/screen/chatting_screen.dart';

class CustomerSupportKeepOpenDialog extends StatelessWidget {
  const CustomerSupportKeepOpenDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Container(
          // height: 460.h,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              5.vs,
              const MyTextField(
                text: "Enter the reason for cancellation",
                headingFontWeight: FontWeight.w600,
                maxLines: 6,
                hintText: "Write down the reason here.",
                isHs20: false,
              ),
              10.vs,
              MyBlueButton(
                hPadding: 25.w,
                vPadding: 14.h,
                text: "Submit it",
                onTap: () {
    Navigator.of(context).pushScreen(
                              ChattingScreen(isChatWithPro: false),
                            );
                },
              ),
              10.vs
            ],
          ),
        ),
      ),
    );
  }
}
