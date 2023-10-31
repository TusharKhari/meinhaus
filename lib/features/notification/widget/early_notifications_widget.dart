import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'notification_card_widget.dart';

class EarlyNotificationWidget extends StatelessWidget {
  const EarlyNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: MyTextPoppines(
            text: "EARLIER",
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        const NotificationCardWidget(
          iconImgUrl: "assets/icons/ticket.svg",
          notifiHeading: "Your ticket has been closed by admin",
          notifiSubHeading: "Ticket closure",
          notifiTime: "2h Ago",
          isSvg: true,
        ),
        10.vs,
        const NotificationCardWidget(
          iconImgUrl: "assets/icons/ok.svg",
          notifiHeading: "Your project has been marked as completed by pro",
          notifiSubHeading: "Project Status",
          notifiTime: "3w Ago",
          isFreshNotifi: false,
          isSvg: true,
        )
      ],
    );
  }
}
