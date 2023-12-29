import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../../resources/font_size/font_size.dart';

class ProProfileWidgetStatic extends StatelessWidget {
  const ProProfileWidgetStatic({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final proServiceOffered = [
      "Electrical",
      "Carpentry Framing",
      "Appliance Install",
      "Plumbing",
      "Tiling"
    ];
    final height = size.height;
    final width = size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pro -> Profile/Name/Company Name/Moto
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundImage:
                    AssetImage("assets/images/contractor_profile.png"),
                // backgroundImage: const AssetImage("assets/images/man.png"),
              ),
              20.hs,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextPoppines(
                    text: "Johnny Jones",
                    fontSize: size.height * FontSize.sixteen,
                    // fontSize: size.height * FontSize.sixteen,
                    fontWeight: FontWeight.bold,
                  ),
                  5.vs,
                  MyTextPoppines(
                    text: "Johns Renovations",
                    fontSize: size.height * FontSize.sixteen,
                    // fontSize: size.height * FontSize.sixteen,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black.withOpacity(0.6),
                  ),
                  5.vs,
                  SizedBox(
                    width: size.width * 0.5,
                    child: MyTextPoppines(
                      text: "Our mission is quality Renovations!",
                      fontSize: size.height * FontSize.sixteen,
                      // fontSize: size.height * FontSize.sixteen,
                      fontWeight: FontWeight.bold,
                      color: AppColors.grey,
                      maxLines: 5,
                    ),
                  ),
                ],
              )
            ],
          ),
          5.vs,
          Divider(thickness: 0.8),
          10.vs,
          // Verfied Pro + No. Of Jobs completed
          Row(
            children: [
              Container(
                width: width / 3.1,
                decoration: BoxDecoration(
                  color: Color(0xFF13F200).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: width / 32,
                  vertical: height / 80,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset("assets/icons/approved_verified.svg"),
                    // Image.asset("assets/icons/approved.png"),
                    MyTextPoppines(
                      text: "Verified Pro",
                      height: 1.8,
                      fontSize: size.height * FontSize.thirteen,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              30.hs,
              Container(
                width: context.screenWidth / 2.8,
                decoration: BoxDecoration(
                  color: Color(0xFFE8F4FF),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: Row(
                  children: [
                    MyTextPoppines(
                      text: "",
                      height: 1.8,
                      fontSize: size.height * FontSize.thirteen,
                      // fontSize:   13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    5.hs,
                    MyTextPoppines(
                      text: "Jobs Completed",
                      height: 1.8,
                      fontSize: size.height * FontSize.thirteen,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ],
          ),
          5.vs,
          Divider(thickness: 0.8),
          10.vs,
          MyTextPoppines(
            text: "Services Offered :",
            fontSize: size.height * FontSize.sixteen,
            fontWeight: FontWeight.w500,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, top: 10.h),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: proServiceOffered.length,
              itemBuilder: (context, index) {
                final String? service = proServiceOffered[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: MyTextPoppines(
                    text: "•   $service",
                    fontSize: size.height * FontSize.fourteen,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black.withOpacity(0.6),
                  ),
                );
              },
            ),
          ),
          5.vs,
          Divider(thickness: 0.8),
          10.vs,
          MeinHouseProRatingCardStatic(),
          20.vs,

          /// ProRecentProjectsCardWidget()
        ],
      ),
    );
  }
}

///
///
///

class MeinHouseProRatingCardStatic extends StatelessWidget {
  const MeinHouseProRatingCardStatic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.white,
        //boxShadow: boxShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.vs,
          MyTextPoppines(
            text: "Pro Rating",
            fontSize: size.height * FontSize.fourteen,
            // fontSize: context.screenHeight / MyFontSize.font14,
            fontWeight: FontWeight.w600,
          ),
          Divider(thickness: 0.8),
          5.vs,
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: const Color(0xFFF3F9FF),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: Colors.amber.shade600,
                      size: 40.sp,
                    ),
                    6.hs,
                    MyTextPoppines(
                      text: "5/5",
                      fontSize: size.height * FontSize.fourteen,
                      // fontSize: context.screenHeight / MyFontSize.font14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textBlue,
                    ),
                    10.hs,
                  ],
                ),
              ),
              10.hs,
              MyTextPoppines(
                text: "2 Customer ratings",
                fontSize: size.height * FontSize.twelve,
                // fontSize: context.screenHeight / MyFontSize.font10,
                fontWeight: FontWeight.w600,
                color: AppColors.black.withOpacity(0.6),
              ),
            ],
          ),
          10.vs,
          Divider(thickness: 0.8),
          RatingCardStatusContant(
            size: size,
            title: "Responsive",
            // valueNo: "(22)",
            valueProgress: 100 * 0.01,
          ),
          RatingCardStatusContant(
            size: size,
            title: "Punctuality",
            //  valueNo: "(10)",
            valueProgress: 100 * 0.01,
          ),
          RatingCardStatusContant(
            size: size,
            title: "Quality",
            //    valueNo: "(54)",
            valueProgress: 100 * 0.01,
          )
        ],
      ),
    );
  }
}

class RatingCardStatusContant extends StatelessWidget {
  const RatingCardStatusContant({
    super.key,
    required this.size,
    required this.title,
    //  required this.valueNo,
    required this.valueProgress,
  });

  final Size size;
  final String title;
  final double valueProgress;
  // final String valueNo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: size.width * 0.24,
            child: MyTextPoppines(
              text: title,
              fontSize: size.height * 0.015,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 14),
            width: size.width * 0.4,
            height: size.height * 0.016,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: valueProgress,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xffFFBC48),
                ),
                backgroundColor: const Color(0xffECF3F7),
              ),
            ),
          ),
          // MyTextPoppines(
          //   text: valueNo,
          //   fontSize: size.height * 0.015,
          //   fontWeight: FontWeight.w400,
          // ),
        ],
      ),
    );
  }
}
