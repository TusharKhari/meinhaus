import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';
import '../../customer support/screens/customer_support_chat_screen.dart';
import '../../customer support/widget/customer_bottom_sheet.dart';

class ChatWithProScreen extends StatelessWidget {
  static const String routeName = '/chatwithpro';
  const ChatWithProScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(w, h / 14),
        child: ProChatAppBar(),
      ),
      backgroundColor: AppColors.white,
      body: Column(
        children: [
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
                            RecivedMessage(
                              sendText:
                                  "To try how it work tap on this meessage",
                              timeOfText: message.time,
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
      bottomSheet: const CustomerBottomSheet(isSupportChat: false),
    );
  }
}

class ProjectDetailsBlock extends StatelessWidget {
  const ProjectDetailsBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Container(
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
              SizedBox(height: h / 200),
              MyTextPoppines(
                text: "OD-79E9646",
                fontSize: w / 40,
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
    );
  }
}

class NoMessageYetWidget extends StatelessWidget {
  const NoMessageYetWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(w / 20),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(12, 0, 0, 0),
            offset: const Offset(0, 0),
            blurRadius: w / 40,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: w / 10,
        vertical: h / 20,
      ),
      child: Column(
        children: [
          MyTextPoppines(
            text: "No Messages yet..!",
            fontSize: w / 20,
            color: AppColors.yellow,
          ),
          SizedBox(height: h / 40),
          MyTextPoppines(
            text: "Send a message to \n     chat with Pro..!",
            fontSize: w / 24,
            color: AppColors.black.withOpacity(0.4),
          ),
          SizedBox(height: h / 40),
          SizedBox(
            height: h / 8,
            width: w / 2,
            child: Image.asset("assets/icons/message.png"),
          ),
        ],
      ),
    );
  }
}

class ProChatAppBar extends StatelessWidget {
  const ProChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return AppBar(
      backgroundColor: Colors.white,
      leading: InkWell(
        onTap: () => Navigator.pop(context),
        child: Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.black,
          size: w / 20,
        ),
      ),
      titleSpacing: 0,
      elevation: 0.0,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CircleAvatar(radius: w / 22),
              Positioned(
                right: 0,
                top: h / 300,
                child: CircleAvatar(
                  radius: w / 100,
                  backgroundColor: AppColors.green,
                ),
              ),
            ],
          ),
          SizedBox(width: w / 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h / 200),
              MyTextPoppines(
                text: "Nate Diaz",
                fontSize: w / 28,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: h / 230),
              Row(
                children: [
                  MyTextPoppines(
                    text: "  Active now",
                    fontSize: w / 40,
                    color: AppColors.black.withOpacity(0.4),
                  ),
                  5.hs,
                  CircleAvatar(
                    radius: w / 100,
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
          size: w / 22,
        ),
        SizedBox(width: w / 40),
      ],
    );
  }
}
