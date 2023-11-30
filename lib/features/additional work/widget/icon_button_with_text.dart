// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../resources/common/my_text.dart';
import '../../../resources/font_size/font_size.dart';

class IconButtonWithText extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final Color? textColor;
  final VoidCallback onTap;
  final String? iconUrl;
  final bool? isIcon;
  final double? hPadding;
  final double? vPadding;
  final double? borderRadius;

  const IconButtonWithText({
    Key? key,
    required this.text,
    required this.buttonColor,
    this.textColor = AppColors.white,
    required this.onTap,
    this.iconUrl,
    this.isIcon = true,
    this.hPadding,
    this.vPadding,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
 final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: hPadding ?? 10.w,
          vertical: vPadding ?? 8.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
          color: buttonColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isIcon!
                ? Container(
                    width: 20.w,
                    height: 20.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(
                        width: 2.w,
                        color: textColor!,
                      ),
                    ),
                    child: Icon(
                      CupertinoIcons.xmark,
                      color: textColor,
                      size: size.height * FontSize.twelve,
                    ),
                  )
                : SizedBox(
                    width: height > 800 ? 20.w : 22.w,
                    height: height > 800 ? 20.w : 22.w,
                    child:
                        //  Image.asset(
                        //   iconUrl!,
                        //   fit: BoxFit.fill,
                        // ),
                        SvgPicture.asset(
                      iconUrl!,
                      height: height * 0.02,
                      fit: BoxFit.fitHeight,
                    ),
                  ),

            10.hs,
            MyTextPoppines(
              text: text,
              color: textColor,
              fontSize: size.height * FontSize.sixteen,
              // fontSize: size.height * FontSize.fourteen,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
