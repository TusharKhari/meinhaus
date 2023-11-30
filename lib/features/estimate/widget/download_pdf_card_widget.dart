// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../resources/font_size/font_size.dart';

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
    final h = context.screenHeight;
    final w = context.screenWidth;
     final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: w / 28, vertical: h / 85),
      color: AppColors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: h / 300),
            child: isAddonWork!
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: w / 1.1,
                        child: MyTextPoppines(
                          text: workName,
                          fontSize: size.height * FontSize.sixteen,
                          color: AppColors.white,
                        ),
                      ),
                      3.vs,
                      MyTextPoppines(
                        text: projectId!,
                       fontSize: size.height * FontSize.twelve,
                        // fontSize: height / MyFontSize.font11,
                        color: AppColors.yellow,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  )
                : SizedBox(
                    width: w / 1.1,
                    child: MyTextPoppines(
                      text: workName,
                      fontSize: size.height * FontSize.sixteen,
                      color: AppColors.white,
                    ),
                  ),
          ), 
        ],
      ),
    );
  }
}
