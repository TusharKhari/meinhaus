// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/features/customer%20support/widget/customer_bottom_sheet.dart';
import 'package:new_user_side/features/home/screens/home_screen.dart';
import 'package:new_user_side/res/common/buttons/my_buttons.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/static%20componets/dialogs/customer_close_ticket_dialog.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

class CustomerSupportChatScreen extends StatefulWidget {
  static const String routeName = '/supportChat';
  const CustomerSupportChatScreen({super.key});

  @override
  State<CustomerSupportChatScreen> createState() =>
      _CustomerSupportChatScreenState();
}

class _CustomerSupportChatScreenState extends State<CustomerSupportChatScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.0,
        leading: Image.asset("assets/icons/support_2.png"),
        titleSpacing: 4.0,
        title: MyTextPoppines(
          text: "Customer support",
          fontSize: 16.sp,
        ),
        actions: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 12.h),
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  width: 1.0,
                  color: AppColors.grey.withOpacity(0.4),
                ),
              ),
              child: Icon(
                CupertinoIcons.xmark,
                color: AppColors.black,
                size: 18.sp,
              ),
            ),
          ),
          10.hs,
        ],
      ),
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
                  // No message yet
                  Consumer<SupportUserMessagesProvider>(
                    builder: (context, value, child) {
                      if (value.messagesList.isNotEmpty) {
                        final message = value.messagesList.last;
                        return Column(
                          children: [
                            UserMessageToSupport(
                              sendText: message.text,
                              timeOfText: message.time,
                            ),
                            SupportMessageToUser(
                              sendText: "This Feature is not working yet..!",
                              timeOfText: message.time,
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const CustosmerCloseTicketDialog();
                                  },
                                );
                              },
                              child: SupportMessageToUser(
                                sendText:
                                    "To try how it work tap on this meessage",
                                timeOfText: message.time,
                              ),
                            ),
                            UserMessageToSupport(
                              isConvoEnd: true,
                              sendText: "Conversation end Succesfully",
                              timeOfText: message.time,
                            ),
                          ],
                        );
                      } else {
                        return Padding(
                          padding: EdgeInsets.only(top: 120.h),
                          child: Container(
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.w, vertical: 40.h),
                            child: Column(
                              children: [
                                MyTextPoppines(
                                  text: "No Messages yet..!",
                                  fontSize: 20.sp,
                                  color: AppColors.yellow,
                                ),
                                20.vs,
                                MyTextPoppines(
                                  text:
                                      "Send a message to \n     chat with Pro..!",
                                  fontSize: 16.sp,
                                  color: AppColors.black.withOpacity(0.4),
                                ),
                                20.vs,
                                SizedBox(
                                  height: 96.h,
                                  width: 101.w,
                                  child:
                                      Image.asset("assets/icons/message.png"),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Consumer<SupportUserMessagesProvider>(
        builder: (context, value, child) {
          if (!value.isConversationEnds) {
            return const CustomerBottomSheet();
          } else {
            return const CustomerEndConvoBottomSheet();
          }
        },
      ),
    );
  }
}

class UserMessageToSupport extends StatelessWidget {
  final String sendText;
  final String timeOfText;
  final bool? isConvoEnd;
  const UserMessageToSupport({
    Key? key,
    required this.sendText,
    required this.timeOfText,
    this.isConvoEnd = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 90.w, top: 10.h, bottom: 10.h, right: 4.w),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
          bottomLeft: Radius.circular(20.r),
        ),
        color: isConvoEnd!
            ? AppColors.yellow.withOpacity(0.12)
            : const Color(0xFF22577A).withOpacity(0.7),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 200.w,
            child: MyTextPoppines(
              text: sendText,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: isConvoEnd! ? AppColors.black : AppColors.white,
              maxLines: 20,
            ),
          ),
          MyTextPoppines(
            text: timeOfText,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: isConvoEnd!
                ? AppColors.black.withOpacity(0.6)
                : AppColors.white.withOpacity(0.6),
            maxLines: 20,
          ),
        ],
      ),
    );
  }
}

class SupportMessageToUser extends StatelessWidget {
  final String sendText;
  final String timeOfText;
  const SupportMessageToUser({
    Key? key,
    required this.sendText,
    required this.timeOfText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      //  crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        10.hs,
        SizedBox(
          height: 30.h,
          width: 30.w,
          child: Image.asset("assets/icons/support_2.png"),
        ),
        5.vs,
        Container(
          margin:
              EdgeInsets.only(left: 10.w, top: 10.h, bottom: 10.h, right: 50.w),
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
            color: const Color(0xFFC1C1C1).withOpacity(0.20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 200.w,
                child: MyTextPoppines(
                  text: sendText,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                  maxLines: 20,
                  height: 1.4,
                ),
              ),
              MyTextPoppines(
                text: timeOfText,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black.withOpacity(0.6),
                maxLines: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomerEndConvoBottomSheet extends StatelessWidget {
  const CustomerEndConvoBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: 160.h,
      margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 25.h),
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
        color: AppColors.yellow.withOpacity(0.12),
      ),
      child: Column(
        children: [
          20.vs,
          MyTextPoppines(
            text: "Conversion has been ended succesfully...!",
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center,
          ),
          30.vs,
          MyBlueButton(
            hPadding: 35.w,
            text: "Back To Home",
            onTap: () {
              context.pushNamedRoute(HomeScreen.routeName);
            },
            vPadding: height > 800
                ? 10.h
                : height > 700
                    ? 12.h
                    : 15.h,
          )
        ],
      ),
    );
  }
}
