// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:new_user_side/data/models/pro_message_model.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../data/network/network_api_servcies.dart';
import '../../../provider/notifiers/chat_with_pro_notifier.dart';
import '../../../utils/utils.dart';
import '../../customer support/screens/customer_support_chat_screen.dart';
import '../../customer support/widget/customer_bottom_sheet.dart';

class ChatWithProScreen extends StatefulWidget {
  static const String routeName = '/chatwithpro';
  const ChatWithProScreen({
    Key? key,
    required this.sendUserId,
  }) : super(key: key);
  final String sendUserId;

  @override
  State<ChatWithProScreen> createState() => _ChatWithProScreenState();
}

class _ChatWithProScreenState extends State<ChatWithProScreen> {
  @override
  void initState() {
    super.initState();
    setupPusherChannel();
  }

  Future setupPusherChannel() async {
    final notifier = context.read<ChatWithProNotifier>();
    MapSS body = {"to_user_id": widget.sendUserId};
    await notifier.setupPusher(context, body);
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ChatWithProNotifier>();
    final messages = notifier.proMessages.messages!;
    final h = context.screenHeight;
    final w = context.screenWidth;
    return ModalProgressHUD(
      inAsyncCall: notifier.loading,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(w, h / 14),
          child: ProChatAppBar(),
        ),
        body: Column(
          children: [
            ProjectDetailsBlock(),
            messages.length > 0
                ? Expanded(
                    child: ListView.builder(
                      controller: notifier.scrollController,
                      padding: EdgeInsets.only(bottom: h / 10),
                      // shrinkWrap: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final messageTime = Utils.convertToRailwayTime(
                            message.createdAt.toString());
                        if (message.senderId == widget.sendUserId) {
                          return RecivedMessage(
                            sendText: message.message!,
                            timeOfText: messageTime,
                          );
                        } else {
                          return SendMessage(
                            isConvoEnd: false,
                            sendText: message.message!,
                            timeOfText: messageTime,
                          );
                        }
                      },
                    ),
                  )
                : NoMessageYetWidget(),
          ],
        ),
        bottomSheet: const CustomerBottomSheet(isSupportChat: false),
      ),
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
      margin: EdgeInsets.only(top: h / 7),
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
