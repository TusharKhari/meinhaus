import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/resources/font_size/font_size.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';

class FirstSplashScreen extends StatelessWidget {
  const FirstSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Container(
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
 
        Positioned(
          top: size.height * 0.1,
          // top: 90.h,
          right: 20.w,
          child: Container(
            width: 220.w,
            height: size.height * 0.2,
            // height: 180,
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
          top: size.height * 0.3,
          // top: 270.h,
          child: Container(
            width: 330.w,
            height: size.height * 0.45,
            // height: 320.h,
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
          bottom: size.height * 0.26,
          left: 50.w,
           right: 20.w,
          child: SizedBox(
            width: 300.w,
            child: MyTextPoppines(
              text: "A secure platform for all renovation projects",
              fontSize: size.height * FontSize.nineteen,
              // fontSize: 19.sp,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Positioned(
          bottom: size.height  * 0.2,
          // bottom: 140.h,
          left: 20.w,
          right: 20.w,
          child: SizedBox(
            width: 350.w,
            child: MyTextPoppines(
              text: "24/7  Customer Support Hire renovators instantly.",
              fontSize: size.height * FontSize.seventeen,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
              color: AppColors.orange ,
            ),
          ),
        ),
      ]),
    );
  }
}
