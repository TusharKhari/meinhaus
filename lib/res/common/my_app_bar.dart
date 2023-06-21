import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/sizer.dart';

import '../../utils/constants/app_colors.dart';
import 'my_text.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final Color? textColor;
  final bool? isLogoVis;
  final VoidCallback? onBack;
  MyAppBar({
    Key? key,
    required this.text,
    this.textColor,
    this.isLogoVis = false,
    this.onBack,
  })  : preferredSize = Size.fromHeight(70),
        super(key: key);
  @override
  final Size preferredSize;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return PreferredSize(
      preferredSize: preferredSize,
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leadingWidth: 60.w,
            leading: Padding(
              padding: EdgeInsets.only(left: 20.w, top: 15.h),
              child: InkWell(
                onTap: onBack ?? () => Navigator.pop(context),
                child: Container(
                  width: 35.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      width: 1.5,
                      color: AppColors.grey.withOpacity(0.4),
                    ),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColors.black,
                    size: height / MyFontSize.font16,
                  ),
                ),
              ),
            ),
            title: Padding(
              padding: EdgeInsets.only(top: 22.h),
              child: MyTextPoppines(
                text: text,
                fontSize: height > 800
                    ? height / MyFontSize.font20
                    : height / MyFontSize.font22,
                fontWeight: FontWeight.w500,
                color: textColor ?? AppColors.black,
              ),
            ),
            centerTitle: true,
            actions: isLogoVis!
                ? [
                    Padding(
                      padding: EdgeInsets.only(top: 15.h),
                      child: Image.asset(
                        "assets/logo/home.png",
                        scale: 1.5,
                      ),
                    ),
                    10.hs,
                  ]
                : [],
          ),
          10.vs,
          const Divider(thickness: 1.8, height: 0.0)
        ],
      ),
    );
  }
}
