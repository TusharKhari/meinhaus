// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import 'package:new_user_side/provider/notifiers/chat_with_pro_notifier.dart';
import 'package:new_user_side/res/common/my_app_bar.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../utils/constants/app_list.dart';
import 'chat_with_pro_screen.dart';

class ChatWIthProChatListScreen extends StatefulWidget {
  static const String routeName = '/chatList';
  const ChatWIthProChatListScreen({super.key});

  @override
  State<ChatWIthProChatListScreen> createState() =>
      _ChatWIthProChatListScreenState();
}

class _ChatWIthProChatListScreenState extends State<ChatWIthProChatListScreen> {
  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ChatWithProNotifier>();
    final conversationList = notifier.conversationsList;
    return ModalProgressHUD(
      inAsyncCall: notifier.loading,
      child: Scaffold(
        appBar: MyAppBar(text: "Messages"),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: conversationList.conversations!.length,
              itemBuilder: (context, index) {
                final newList = conversationList.conversations![index];
                final list = chatList[index];
                return ChatCardWidget(
                  isSend: list[0],
                  isReaded: list[1],
                  profilePic: list[2],
                  userName: newList.toUserName.toString(),
                  message: list[4],
                  textTime: list[5],
                  projectName: list[6],
                  onTap: () => Navigator.of(context).pushScreen(
                    ChatWithProScreen(
                      sendUserId: newList.toUserId!,
                    ),
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}

class ChatCardWidget extends StatelessWidget {
  final bool isSend;
  final bool isReaded;
  final String profilePic;
  final String userName;
  final String message;
  final String textTime;
  final String projectName;
  final VoidCallback onTap;

  const ChatCardWidget({
    Key? key,
    required this.isSend,
    required this.isReaded,
    required this.profilePic,
    required this.userName,
    required this.message,
    required this.textTime,
    required this.projectName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: w / 30, vertical: h / 60),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: w / 14,
              backgroundImage: AssetImage(profilePic),
            ),
            SizedBox(width: w / 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: h / 200),
                MyTextPoppines(
                  text: projectName,
                  fontSize: w / 28,
                  color: AppColors.buttonBlue,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: h / 160),
                MyTextPoppines(
                  text: userName,
                  fontSize: w / 32,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: h / 300),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isSend
                        ? MyTextPoppines(
                            text: "You :  ",
                            fontSize: w / 40,
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                          )
                        : const SizedBox(),
                    SizedBox(
                      width: isSend ? w / 1.9 : w / 1.6,
                      child: MyTextPoppines(
                        text:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, ... ",
                        fontSize: w / 40,
                        maxLines: 1,
                        height: 1.4,
                        color: isReaded
                            ? AppColors.black.withOpacity(0.5)
                            : AppColors.black.withOpacity(0.8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            isReaded ? SizedBox(width: w / 40) : SizedBox(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: h / 120),
                MyTextPoppines(
                  text: textTime,
                  fontSize: w / 45,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: h / 120),
                isReaded
                    ? const SizedBox()
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(w / 20),
                          color: AppColors.yellow,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: w / 50, vertical: h / 300),
                        child: MyTextPoppines(
                          text: "4",
                          fontSize: w / 45,
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      )
              ],
            )
          ],
        ),
      ),
    );
  }
}
