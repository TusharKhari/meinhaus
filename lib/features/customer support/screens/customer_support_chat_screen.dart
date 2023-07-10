// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:new_user_side/features/customer%20support/widget/customer_bottom_sheet.dart';
import 'package:new_user_side/features/home/screens/home_screen.dart';
import 'package:new_user_side/res/common/buttons/my_buttons.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/static%20componets/dialogs/customer_close_ticket_dialog.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../utils/download_files/download_file.dart';
import '../../chat with pro/widget/chat_no_message_yet.dart';
import '../../chat with pro/widget/chat_project_details_block.dart';

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
          ProjectDetailsBlock(),
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
                            SendMessage(
                              sendText: message.text,
                              timeOfText: message.time,
                            ),
                            RecivedMessage(
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
                              child: RecivedMessage(
                                sendText:
                                    "To try how it work tap on this meessage",
                                timeOfText: message.time,
                              ),
                            ),
                            SendMessage(
                              isConvoEnd: true,
                              sendText: "Conversation end Succesfully",
                              timeOfText: message.time,
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            SizedBox(height: h / 6),
                            // No message yet
                            NoMessageYetWidget(),
                          ],
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

// SEND MESSAGES
class SendMessage extends StatelessWidget {
  final String sendText;
  final String timeOfText;
  final bool? isConvoEnd;
  final bool? isSeen;
  final int? messageState;
  final String? messageType;
  const SendMessage({
    Key? key,
    required this.sendText,
    required this.timeOfText,
    this.isConvoEnd = false,
    this.isSeen = false,
    this.messageState = 1,
    this.messageType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Container(
      margin: EdgeInsets.only(
        left: w / 4,
        top: h / 80,
        bottom: h / 80,
        right: w / 80,
      ),
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
          mType(messageType!, context),
          MyTextPoppines(
            text: timeOfText,
            fontSize: w / 32,
            fontWeight: FontWeight.w500,
            color: isConvoEnd!
                ? AppColors.black.withOpacity(0.6)
                : AppColors.white.withOpacity(0.6),
            maxLines: 20,
          ),
          Icon(
            setIcon(messageState!),
            size: w / 25,
            color: setIconColor(messageState!),
          )
        ],
      ),
    );
  }

  Widget mType(String type, BuildContext context) {
    final w = context.screenWidth;
    final textMessage = SizedBox(
      width: w / 1.9,
      child: MyTextPoppines(
        text: sendText,
        fontSize: w / 32,
        fontWeight: FontWeight.w500,
        color: isConvoEnd! ? AppColors.black : AppColors.white,
        maxLines: 100,
      ),
    );
    final pdfMessage = DownloadFile(fileNmae: sendText);
    final imgMessage = SizedBox(
      width: w / 1.9,
      child: InkWell(
        onTap: () => Navigator.of(context).pushScreen(
          PreviewChatImages(imgPath: sendText),
        ),
        child: Hero(
          tag: sendText,
          child: Image.network(sendText),
        ),
      ),
    );

    switch (type) {
      case "text":
        return textMessage;
      case "pdf":
        return pdfMessage;
      case "png":
        return imgMessage;
      case "jpg":
        return imgMessage;
      case "webp":
        return imgMessage;
      default:
        return textMessage;
    }
  }

  IconData setIcon(int messageState) {
    switch (messageState) {
      case 0:
        return Icons.access_time_outlined;
      case 1:
        return Icons.done_all;
      case 2:
        return Icons.done_all;
      case 3:
        return Icons.error_outline;
      default:
        return Icons.done;
    }
  }

  Color setIconColor(int messageState) {
    switch (messageState) {
      case 0:
        return Colors.white;
      case 1:
        return Colors.white;
      case 2:
        return Colors.lightBlue;
      case 3:
        return Colors.red;
      default:
        return Colors.white;
    }
  }
}

// RECIVED MESSAGES
class RecivedMessage extends StatelessWidget {
  final String sendText;
  final String timeOfText;
  final String? messageType;
  const RecivedMessage({
    Key? key,
    required this.sendText,
    required this.timeOfText,
    this.messageType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Row(
      children: [
        SizedBox(width: w / 38),
        // Sender Img
        Image.asset(
          "assets/icons/support_2.png",
          height: h / 30,
          width: w / 15,
        ),
        SizedBox(width: w / 80),
        // Message
        Container(
          margin: EdgeInsets.only(
            left: w / 38,
            top: h / 80,
            bottom: h / 80,
            right: w / 6,
          ),
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
              mType(messageType!, context),
              SizedBox(width: w / 60),
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

  Widget mType(String type, BuildContext context) {
    final w = context.screenWidth;
    final textMessage = SizedBox(
      width: w / 1.9,
      child: MyTextPoppines(
        text: sendText,
        fontSize: w / 32,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
        maxLines: 100,
      ),
    );
    final pdfMessage = DownloadFile(fileNmae: sendText);
    final imgMessage = SizedBox(
      width: w / 1.9,
      child: InkWell(
        onTap: () => Navigator.of(context).pushScreen(
          PreviewChatImages(imgPath: sendText),
        ),
        child: Hero(
          tag: sendText,
          child: Image.network(sendText),
        ),
      ),
    );
    switch (type) {
      case "text":
        return textMessage;
      case "pdf":
        return pdfMessage;
      case "png":
        return imgMessage;
      case "jpg":
        return imgMessage;
      default:
        return textMessage;
    }
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

class PreviewChatImages extends StatelessWidget {
  final String imgPath;
  const PreviewChatImages({
    Key? key,
    required this.imgPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: w / 22,
          ),
        ),
        title: MyTextPoppines(
          text: "Preview Image",
          color: AppColors.white,
          fontSize: w / 22,
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: InteractiveViewer(
            child: Hero(
              tag: imgPath,
              child: Image.network(
                imgPath,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
