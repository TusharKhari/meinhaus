import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';

class FirstSplashScreen extends StatelessWidget {
  const FirstSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(children: [
        Positioned(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/workers/bg_3.png",
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Positioned(
          top: 80.h,
          right: 20.w,
          child: Container(
            width: 220.w,
            height: 180.h,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                 // "assets/images/workers/worker_3.png",
                 "assets/images/splashScreen/image 253.png",
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Positioned(
          top: 280.h,
          left: 0.w,
          child: Container(
            width: 330.w,
            height: 320.h,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  // "assets/images/workers/worker_6.png",
                  "assets/images/splashScreen/image 250.png"
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 190.h,
          left: 50.w,
          child: SizedBox(
            width: 300.w,
            child: MyTextPoppines(
              text: "A secure platform for all renovation projects",
              fontSize: height > 800 ? 18.sp : 22.sp,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Positioned(
          bottom: 160.h,
          left: 20.w,
          child: SizedBox(
            width: 350.w,
            child: MyTextPoppines(
              text: "24/7  Customer support. Hire renovators instantly.",
              fontSize: height > 800 ? 10.sp : 12.sp,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
              color: AppColors.black.withOpacity(0.6),
            ),
          ),
        ),
      ]),
    );
  }
}
