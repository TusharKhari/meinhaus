// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/res/common/my_app_bar.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import '../widget/early_notifications_widget.dart';
import '../widget/today_notification_widget.dart';

class NotificationScreen extends StatelessWidget {
  static const String routeName = '/notification';
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(text: "Notifications"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: MyTextPoppines(
                text: "Stay up to date",
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            const TodaysNotificationWidget(),
            10.vs,
            const EarlyNotificationWidget()
          ],
        ),
      ),
    );
  }
}
