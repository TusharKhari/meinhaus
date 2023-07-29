import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

enum BarState { Success, Error, Warning, Info }

void showSnakeBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      duration: Duration(seconds: 2),
      content: Container(
        padding: EdgeInsets.all(10.h.w),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: MyTextPoppines(
          text: text,
          color: AppColors.white,
          fontWeight: FontWeight.w600,
          maxLines: 10,
        ),
      ),
    ),
  );
}

void showSnakeBarr(
  BuildContext context,
  String text,
  BarState state,
) {
  final width = context.screenWidth;
  final mainColor;
  final IconData icon;
  switch (state) {
    case BarState.Success:
      mainColor = Colors.green;
      icon = (Icons.done);
      break;
    case BarState.Error:
      mainColor = Colors.red;
      icon = (Icons.error_outline);
      break;
    case BarState.Warning:
      mainColor = Colors.orange;
      icon = (Icons.warning_amber_rounded);
      break;
    case BarState.Info:
      mainColor = Colors.blue;
      icon = (Icons.info_outline);
      break;
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      duration: Duration(seconds: 4),
      content: Container(
        padding: EdgeInsets.all(10.h.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: mainColor, width: 2),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.0, 0.3),
              color: mainColor[200],
              blurRadius: 10.r,
            )
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: mainColor, size: width / 15),
            SizedBox(width: width / 90),
            SizedBox(
              width: width / 1.4,
              child: MyTextPoppines(
                text: text,
                color: mainColor,
                fontWeight: FontWeight.w600,
                fontSize: width / 28,
                maxLines: 10,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
