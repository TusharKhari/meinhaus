import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/resources/common/buttons/my_buttons.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../resources/font_size/font_size.dart';
import '../../estimate/screens/estimate_generation_screen.dart';

class HomeOfferBannerOld extends StatelessWidget {
  const HomeOfferBannerOld({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    BorderRadius borderRadius = BorderRadius.circular(24.r);
    final size = MediaQuery.of(context).size;
    Border border = Border.all(
      width: 1.2,
      color: AppColors.grey.withOpacity(0.2),
    );
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      width: double.infinity,
      height: height / 4.46,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: border,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: border,
          image: const DecorationImage(
            image: AssetImage("assets/images/room/house.png"),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Row(
          children: [
            20.hs,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                height > 800 ? 20.vs : 25.vs,
                MyTextPoppines(
                  text: "Get 20% OFF",
                  // fontSize:
                  // height > 800
                  // ? height / MyFontSize.font20
                  // : height / MyFontSize.font24,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
                15.vs,
                SizedBox(
                  width: 200.w,
                  child: MyTextPoppines(
                    text: "Tap on banner to see more in details.",
                    fontSize: size.height * FontSize.twelve,
                    //fontSize:
                    //  height > 800
                    //     ? height / MyFontSize.font10
                    //     : height / MyFontSize.font14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                    height: 1.2.h,
                  ),
                ),
                15.vs,
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      border: Border.all(
                        width: 1.2.w,
                        color: AppColors.white,
                      ),
                      color: AppColors.buttonBlue,
                    ),
                    child: Center(
                      child: MyTextPoppines(
                        text: "View Details",
                        fontSize: size.height * FontSize.fourteen,
                        // fontSize: height / MyFontSize.font12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: double.infinity,
              width: 110.w,
              child: Image.asset(
                "assets/images/workers/worker_1.png",
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ========

class HomeOfferBanner extends StatefulWidget {
  const HomeOfferBanner({super.key});

  @override
  State<HomeOfferBanner> createState() => _HomeOfferBannerState();
}

class _HomeOfferBannerState extends State<HomeOfferBanner> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    BorderRadius borderRadius = BorderRadius.circular(24.r);
    Border border = Border.all(
      width: 1.2,
      color: AppColors.grey.withOpacity(0.2),
    );
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      width: double.infinity,
      height: size.height / 4.46,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(
          width: 1.2,
          color: AppColors.golden,
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: border,
          image: const DecorationImage(
            image: AssetImage("assets/images/room/house.png"),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Row(
          children: [
            20.hs,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text("Get an instant quote for any project, anytime."),
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: "Get an ",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: "instant ",
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.golden),
                  ),
                  TextSpan(
                    text: "quote",
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.golden),
                  ),
                ])),

                MyBlueButton(
                  hPadding: size.width * 0.028,
                  vPadding: size.height * 0.01,
                  fontSize: size.height * FontSize.fourteen,
                  text: "Create Estimate",
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      EstimateGenerationScreen.routeName,
                      arguments: true,
                    );
                  },
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Try our 3D image generator AI \n",
                        style: TextStyle(
                          fontSize: size.height * FontSize.thirteen,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                      ),
                      TextSpan(
                        text: "*coming soon...",
                        style: TextStyle(
                          fontSize: size.height * FontSize.eleven,
                          fontWeight: FontWeight.w500,
                          color: AppColors.golden,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: double.infinity,
              width: 110.w,
              child: Image.asset(
                "assets/images/workers/worker_1.png",
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
