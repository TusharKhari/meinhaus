import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/resources/common/buttons/my_buttons.dart';
 import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../resources/font_size/font_size.dart';
import '../../estimate/screens/estimate_generation_screen.dart';



// ========

class HomeOfferBanner extends StatefulWidget {
  final bool? isDemoEstimate;
  const HomeOfferBanner({super.key, this.isDemoEstimate = false});

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
        // margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        margin: EdgeInsets.all(3.w),
        padding: EdgeInsets.only(left: 10.w),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff001D57),
          borderRadius: borderRadius,
          border: border,
          // image: const DecorationImage(
          //   image: AssetImage("assets/images/room/house.png"),
          //   fit: BoxFit.fitWidth,
          // ),
        ),
        child: Row(
          children: [
            4.hs,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Free instant quote",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "NO OBLIGATION",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.golden,
                  ),
                ),
                MyBlueButton(
                  hPadding: size.width * 0.028,
                  vPadding: size.height * 0.01,
                  fontSize: size.height * FontSize.fourteen,
                  text: "Create Estimate",
                  onTap: () {
                    // Navigator.pushNamed(
                    //   context,
                    //   EstimateGenerationScreen.routeName,
                    //   arguments: true,
                    // );
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return EstimateGenerationScreen(
                          isDemoEstimate: widget.isDemoEstimate,
                        );
                      },
                    ));
                  },
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Try our 3D image generator AI \n",
                        style: TextStyle(
                          fontSize: size.height * FontSize.fifteen,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                      ),
                      TextSpan(
                        text: "*coming soon...",
                        style: TextStyle(
                          fontSize: size.height * FontSize.thirteen,
                          fontWeight: FontWeight.w500,
                          color: AppColors.golden,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            // Image.asset(
            //   "assets/images/workers/worker_1.png",
            //   fit: BoxFit.cover,
            //   width: size.width * 0.26,
            // ),
          ],
        ),
      ),
    );
  }
}
