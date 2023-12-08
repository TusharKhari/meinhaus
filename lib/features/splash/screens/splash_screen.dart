import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/features/auth/screens/signin_screen.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/features/splash/screens/first_splash_screen.dart';
import 'package:new_user_side/features/splash/screens/second_splash-screen.dart';
import 'package:new_user_side/features/splash/screens/third_splash.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../resources/font_size/font_size.dart';
 

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int index = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: screens.length,
      initialIndex: index,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
 
    return Scaffold(
      body: 
      Stack(
        alignment: Alignment.center,
        children: [
          TabBarView(
            controller: _tabController,
            children: screens,
          ),
          Positioned(
            bottom: size.height * 0.1,
            // bottom: 100.h,
            child: InkWell(
              onTap: () {
                setState(() {
                  index = 0;
                  _tabController.animateTo(index);
                });
              },
              child: TabPageSelector(
                controller: _tabController,
                selectedColor: AppColors.black,
                borderStyle: BorderStyle.solid,
                indicatorSize: 13.sp,
                // indicatorSize: height / MyFontSize.font12,
              ),
            ),
          )
        ],
      ),
      

      floatingActionButton: index != 2
          ? 
          InkWell(
              onTap: () {
                (index != screens.length - 1) ? index++ : index = 0;
                _tabController.animateTo(index);
                setState(() {});
              },
              // Next Button
              child: Container(
                width: height > 800
                    ? 110.w
                    : height > 700
                        ? 100.w
                        : 90.w,
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  border: Border.all(
                    width: 1.5.w,
                    color: AppColors.buttonBlue,
                  ),
                ),
                child: Row(
                  children: [
                    14.hs,
                    Padding(
                      padding: EdgeInsets.only(top: 3.h),
                      child: MyTextPoppines(
                        text: "Next",
                        fontWeight: FontWeight.w600,
                        color: AppColors.buttonBlue,
                         fontSize: size.height * FontSize.sixteen,
                        // fontSize: height / MyFontSize.font16,
                      ),
                    ),
                    10.hs,
                    Icon(
                      Icons.arrow_forward,
                      color: AppColors.buttonBlue,
                      size:   20.sp,
                      // size: height / MyFontSize.font20,
                    ),
                  ],
                ),
              ),
            )
          // Get Started Button
          : 
          InkWell(
              onTap: () => Navigator.pushReplacementNamed(context, SignInScreen.routeName),
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 50.h,
               margin: EdgeInsets.only(left: 40.w, right: 10.w, bottom: height * 0.01),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.r),
                  color: AppColors.buttonBlue,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(74, 0, 0, 0),
                      offset: const Offset(0, 6),
                      blurRadius: 10.r,
                    ),
                  ],
                ),
                child: Center(
                  child: MyTextPoppines(
                    text: "Get Started",
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                    fontSize: size.height * FontSize.sixteen,
                    // fontSize: height / MyFontSize.font16,
                  ),
                ),
              ),
            ),
    );
  }
}

List<Widget> screens = const [
  FirstSplashScreen(),
  SecondSplashScreen(),
  ThirdSplashScreen(),
];
