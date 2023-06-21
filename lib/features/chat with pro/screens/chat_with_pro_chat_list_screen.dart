// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return Scaffold(
      appBar: MyAppBar(
        text: "Message",
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: chatList.length,
            itemBuilder: (context, index) {
              final list = chatList[index];
              return ChatCardWidget(
                isSend: list[0],
                isReaded: list[1],
                profilePic: list[2],
                userName: list[3],
                message: list[4],
                textTime: list[5],
                projectName: list[6],
              );
            },
          ))
        ],
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

  const ChatCardWidget({
    Key? key,
    required this.isSend,
    required this.isReaded,
    required this.profilePic,
    required this.userName,
    required this.message,
    required this.textTime,
    required this.projectName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () => context.pushNamedRoute(ChatWithProScreen.routeName),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30.r,
              backgroundImage: AssetImage(profilePic),
            ),
            10.hs,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                4.vs,
                MyTextPoppines(
                  text: projectName,
                  fontSize: 14.sp,
                  color: AppColors.buttonBlue,
                  fontWeight: FontWeight.w600,
                ),
                6.vs,
                MyTextPoppines(
                  text: userName,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
                2.vs,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isSend
                        ? MyTextPoppines(
                            text: "You :  ",
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                          )
                        : const SizedBox(),
                    SizedBox(
                      width: isSend ? 200.w : 240.w,
                      child: MyTextPoppines(
                        text:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, ... ",
                        fontSize: 10.sp,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MyTextPoppines(
                  text: textTime,
                  fontSize: height > 800 ? 7.sp : 9.sp,
                  fontWeight: FontWeight.w600,
                ),
                5.vs,
                isReaded
                    ? const SizedBox()
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: AppColors.yellow,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 3.h),
                        child: MyTextPoppines(
                          text: "4",
                          fontSize: 9.sp,
                          color: AppColors.white,
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
