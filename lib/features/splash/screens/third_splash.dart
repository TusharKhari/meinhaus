import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/resources/font_size/font_size.dart'; 

class ThirdSplashScreen extends StatelessWidget {
  const ThirdSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/workers/bg_1.png",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.04,
            // top: 30.h,
            right: 0.w,
            child: Container(
              width: 320.w,
              height: height * 0.37,
              // height: 300.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    // "assets/images/workers/worker_7.png",
                    "assets/images/splashScreen/image 216.png",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.3,
            // top: 270.h,
            left: 0.w,
            child: Container(
              width: 320.w,
              height: height * 0.37,
              // height: 300.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    // "assets/images/workers/worker_5.png",
                    "assets/images/splashScreen/image 252.png"
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: height / 5,
            left: 20.w,
            right: 20.w,
            child: Container(
              width: width / 1.15,
              margin: EdgeInsets.symmetric(horizontal: width / 17),
              child: Center(
                child: MyTextPoppines(
                  text:
                      "Have your own pro? No Problem! Book through our platform for a seamless experience at no additional cost",
                  fontSize:height * FontSize.nineteen,
                  // fontSize:19.sp,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  height: width / 300,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
