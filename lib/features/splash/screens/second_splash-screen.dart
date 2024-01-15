import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/resources/font_size/font_size.dart';

import '../../../utils/constants/app_colors.dart';

class SecondSplashScreen extends StatelessWidget {
  const SecondSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(children: [
        Positioned(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/workers/bg_2.png",
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Positioned(
          top: size.height * 0.02,
          // top: 20.h,
          right: 0.w,
          child: Container(
            width: 320.w,
            height: size.height * 0.4,
            // height: 320.h,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  // "assets/images/workers/worker_2.png",
                  "assets/images/splashScreen/image 253-1.png",
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Positioned(
          top: size.height * 0.38,
          // top: 280.h,
          left: 0.w,
          child: Container(
            width: 320.w,
            height: size.height * 0.4,
            // height: 300.h,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  // "assets/images/workers/worker_4.png",
                  "assets/images/splashScreen/image 222.png", 
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Positioned(
          bottom:size.height * 0.26,
          // bottom: 190.h,
          left: 20.w,
          right: 20.w,
          child: SizedBox(
            width: 350.w,
            child: MyTextPoppines(
              text: "Instant quotations tailored to you.",
              fontSize: 
              //height > 800 ? 18.sp : 22.sp,
              size.height * FontSize.nineteen, 
              // 19.sp, 
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
          ),
        ),
        Positioned(
          bottom:size.height  * 0.2,
          // bottom: 140.h,
          left: 20.w,
          child: SizedBox(
            width: 350.w,
            child: MyTextPoppines(
              text:
                  "Pay a fixed price at the best market rates. Guaranteed to completion.  ",
              fontSize: 
              //height > 800 ? size.height * FontSize.fifteen : 17.sp,
              size.height * FontSize.seventeen, 

              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
              color: AppColors.orange,
            ),
          ),
        ),
      ]),
    );
  }
}
