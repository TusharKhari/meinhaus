// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_user_side/features/customer%20support/widget/customer_bottom_sheet.dart';
import 'package:new_user_side/features/home/screens/home_screen.dart';
import 'package:new_user_side/res/common/buttons/my_buttons.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/static%20componets/dialogs/customer_close_ticket_dialog.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/constants/constant.dart';
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
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Scaffold(
      // APPBAR
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.0,
        leading: Image.asset("assets/icons/support_2.png"),
        titleSpacing: 4.0,
        title: MyTextPoppines(text: "Customer support", fontSize: w / 22),
        actions: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: h / 70),
              padding: EdgeInsets.symmetric(horizontal: w / 70),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(w / 40),
                border: Border.all(
                  width: 1.0,
                  color: AppColors.grey.withOpacity(0.4),
                ),
              ),
              child: Icon(
                CupertinoIcons.xmark,
                color: AppColors.black,
                size: w / 22,
              ),
            ),
          ),
          SizedBox(width: w / 30),
        ],
      ),
      body: Column(
        children: [
          // PROJECT DETAILS BANNER
          Container(
            color: AppColors.yellow.withOpacity(0.15),
            padding: EdgeInsets.symmetric(horizontal: w / 20, vertical: h / 70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextPoppines(
                      text: "Furniture Fixing",
                      fontSize: w / 28,
                      fontWeight: FontWeight.w600,
                    ),
                    2.vs,
                    MyTextPoppines(
                      text: "OD-79E9646",
                      fontSize: w / 36,
                      color: AppColors.yellow,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                MyTextPoppines(
                  text: "Project Started On : 15/02/2023",
                  fontSize: w / 34,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // SHOWING MESSAGES
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
                        // NO MESSAGE YET BLOCK
                        return Padding(
                          padding: EdgeInsets.only(top: h / 5.5),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(w / 20),
                              boxShadow: boxShadow,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: w / 10, vertical: h / 20),
                            child: Column(
                              children: [
                                MyTextPoppines(
                                  text: "No Messages yet..!",
                                  fontSize: w / 20,
                                  color: AppColors.yellow,
                                ),
                                SizedBox(height: h / 35),
                                MyTextPoppines(
                                  text: "Send a message to \n chat with Pro..!",
                                  fontSize: w / 25,
                                  color: AppColors.black.withOpacity(0.4),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: h / 35),
                                Image.asset(
                                  "assets/icons/message.png",
                                  height: h / 8,
                                  width: w / 2.3,
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

// USER MESSAGES
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
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Container(
      margin: EdgeInsets.only(
          left: w / 4, top: h / 80, bottom: h / 80, right: w / 80),
      padding: EdgeInsets.symmetric(horizontal: w / 28, vertical: h / 80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(w / 20),
          topRight: Radius.circular(w / 20),
          bottomLeft: Radius.circular(w / 20),
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
            width: w / 1.9,
            child: MyTextPoppines(
              text: sendText,
              fontSize: w / 32,
              fontWeight: FontWeight.w500,
              color: isConvoEnd! ? AppColors.black : AppColors.white,
              maxLines: 100,
            ),
          ),
          MyTextPoppines(
            text: timeOfText,
            fontSize: w / 32,
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


// SUPPORT MESSAGES
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
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Row(
      children: [
        SizedBox(width: w / 38),
        Image.asset(
          "assets/icons/support_2.png",
          height: h / 30,
          width: w / 15,
        ),
        SizedBox(width: w / 80),
        Container(
          margin: EdgeInsets.only(
              left: w / 38, top: h / 80, bottom: h / 80, right: w / 6),
          padding: EdgeInsets.symmetric(horizontal: w / 30, vertical: h / 80),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(w / 20),
              topRight: Radius.circular(w / 20),
              bottomRight: Radius.circular(w / 20),
            ),
            color: const Color(0xFFC1C1C1).withOpacity(0.20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: w / 1.9,
                child: MyTextPoppines(
                  text: sendText,
                  fontSize: w / 32,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                  maxLines: 20,
                  height: 1.4,
                ),
              ),
              MyTextPoppines(
                text: timeOfText,
                fontSize: w / 32,
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


// BACK TO HOME BUTTON
class CustomerEndConvoBottomSheet extends StatelessWidget {
  const CustomerEndConvoBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Container(
      width: double.infinity,
      height: h / 5,
      margin: EdgeInsets.symmetric(horizontal: w / 12, vertical: h / 25),
      padding: EdgeInsets.symmetric(horizontal: w / 10, vertical: h / 80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(w / 26),
        color: AppColors.yellow.withOpacity(0.12),
      ),
      child: Column(
        children: [
          SizedBox(height: 18),
          MyTextPoppines(
            text: "Conversion has been ended succesfully...!",
            fontSize: w / 26,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 18),
          MyBlueButton(
            hPadding: w / 10,
            fontSize: w / 26,
            text: "Back To Home",
            onTap: () {
              context.pushNamedRoute(HomeScreen.routeName);
            },
            vPadding: h / 60,
          )
        ],
      ),
    );
  }
}
