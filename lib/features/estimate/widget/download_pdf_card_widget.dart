// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/sizer.dart';

class DownloadPdfCard extends StatelessWidget {
  final String workName;
  final String? projectId;
  final bool? isAddonWork;
  const DownloadPdfCard({
    Key? key,
    required this.workName,
    this.projectId,
    this.isAddonWork = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      color: AppColors.black,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: isAddonWork!
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextPoppines(
                      text: workName,
                      fontSize: height < 800
                          ? height / MyFontSize.font16
                          : height / MyFontSize.font14,
                      color: AppColors.white,
                    ),
                    3.vs,
                    MyTextPoppines(
                      text: projectId!,
                      fontSize: height / MyFontSize.font11,
                      color: AppColors.yellow,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                )
              : MyTextPoppines(
                  text: workName,
                  fontSize: height < 800
                      ? height / MyFontSize.font16
                      : height / MyFontSize.font14,
                  color: AppColors.white,
                ),
        ),
        Row(
          children: [
            Text(
              "Download as PDF",
              style: GoogleFonts.poppins(
                fontSize: height < 800
                    ? height / MyFontSize.font10
                    : height / MyFontSize.font8,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                color: AppColors.yellow,
                decoration: TextDecoration.underline,
                decorationThickness: 2.0,
                // height: 2,
              ),
            ),
            Icon(
              Icons.file_download_outlined,
              color: AppColors.yellow,
              size: 24.sp,
            ),
          ],
        )
      ]),
    );
  }
}
