import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_user_side/features/all%20conversation/screens/all_conversation_screen.dart';
import 'package:new_user_side/provider/notifiers/notification_notifier.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../provider/notifiers/chat_with_pro_notifier.dart';
import '../../notification/screens/notification_screen.dart';


class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    // AllConversation
    Future allConversation() async {
      final notifier = context.read<ChatWithProNotifier>();
      await notifier.allConversation(context);
      Navigator.of(context).pushNamed(AllConversationScreen.routeName);
    }

    // Load Notifications
    Future loadNotification() async {
      final notificationNotifier = context.read<NotificationNotifier>();
      await notificationNotifier.getNotifications();
      Navigator.of(context).pushNamed(NotificationScreen.routeName);
    }

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leadingWidth: width / 3,
      leading: Row(
        children: [
          SizedBox(width: width / 28),
          Builder(
            builder: (context) => InkWell(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Image.asset(
                "assets/icons/menu.png",
                width: width / 20,
                height: height / 30,
              ),
            ),
          ),
          SizedBox(width: width / 28),
          Image.asset(
            "assets/logo/home.png",
            scale: 1.8,
            width: width / 10,
            height: height / 25,
            fit: BoxFit.cover,
          ),
        ],
      ),
      actions: [
        SizedBox(width: width / 24),
        InkWell(
          onTap: () => allConversation(),
          child: Icon(
            CupertinoIcons.text_bubble,
            color: AppColors.black.withOpacity(0.8),
            size: width / 15,
          ),
        ),
        SizedBox(width: width / 24),
        InkWell(
          onTap: () => loadNotification(),
          child: Icon(
            CupertinoIcons.bell,
            color: AppColors.black.withOpacity(0.8),
            size: width / 15,
          ),
        ),
        SizedBox(width: width / 40),
      ],
    );
  }
}
