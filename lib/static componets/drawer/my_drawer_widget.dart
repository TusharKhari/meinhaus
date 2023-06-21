import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/sizer.dart';
import 'package:provider/provider.dart';

import '../../features/edit profile/screens/edit_profile_screen.dart';
import '../../provider/notifiers/auth_notifier.dart';
import '../../utils/constants/app_list.dart';
import '../dialogs/customer_support_dialog.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
      ),
      width: 270.w,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/drawer_bg.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 60.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 40.w),
                  child: _ExitIcon(),
                ),
                30.vs,
                 _ProfileCard(),
                10.vs,
                Divider(thickness: 1.0),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: _ItemList(),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20.h,
            left: 15.w,
            child: const _LogoutButton(),
          )
        ],
      ),
    );
  }
}

class _ExitIcon extends StatelessWidget {
  const _ExitIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 35.w,
        height: 35.w,
        transform: Matrix4.rotationZ(45 * pi / 180),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: AppColors.black,
            width: 1.2.w,
          ),
        ),
        child: Transform.rotate(
          angle: 45 * pi / 180,
          child: Icon(
            CupertinoIcons.xmark,
            color: AppColors.buttonBlue,
            size: 20.sp,
          ),
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = context.screenHeight;
    final user = context.watch<AuthNotifier>().user;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.symmetric(vertical: 15.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          15.hs,
          // Hey + User name
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTextPoppines(
                text: user.firstname.toString(),
                fontSize: height > 800 ? 18.sp : 20.sp,
                fontWeight: FontWeight.w600,
                height: 1.5,
                maxLines: 1,
              ),
              SizedBox(
                height: 30.h,
                width: 100.w,
                child: MyTextPoppines(
                  text: user.lastname.toString(),
                  fontSize: height > 800 ? 18.sp : 20.sp,
                  fontWeight: FontWeight.w600,
                  maxLines: 1,
                ),
              ),
              5.vs,
              MyTextPoppines(
                text: "View and update \nyour profile",
                fontSize: height > 800 ? 8.sp : 10.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black.withOpacity(0.6),
                height: 1.5,
              ),
            ],
          ),
          height > 800 ? 10.hs : 15.hs,
          // Profile pic + Edit button
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundImage: NetworkImage(user.profilePic != null
                    ? user.profilePic!
                    : "https://as1.ftcdn.net/v2/jpg/02/30/60/82/1000_F_230608264_fhoqBuEyiCPwT0h9RtnsuNAId3hWungP.jpg"),
              ),
              10.vs,
              Container(
                width: 110.w,
                height: 30.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColors.black,
                ),
                child: InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, EditProfileScreen.routeName),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 12.w,
                          top: 2.h,
                          right: 5.w,
                        ),
                        child: MyTextPoppines(
                          text: "Edit Profile",
                          fontSize: height > 800 ? 10.sp : 12.sp,
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(
                        Icons.edit,
                        color: AppColors.white,
                        size: height > 800 ? 16.sp : 18.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          10.hs,
        ],
      ),
    );
  }
}

class _ItemList extends StatelessWidget {
  const _ItemList({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: 260.w,
      height: height / 2.2,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: drawerList.length,
        itemBuilder: (context, index) {
          return Container(
            height: 25.h,
            margin: EdgeInsets.symmetric(vertical: 12.h),
            child: InkWell(
              onTap: () {
                if (index == 6) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const CustomerSupportDialog();
                    },
                  );
                } else {
                  Navigator.pushNamed(
                    context,
                    drawerList[index][2],
                    arguments: true,
                  );
                }
              },
              child: Row(
                children: [
                  Icon(drawerList[index][0], size: 20.sp),
                  10.hs,
                  Padding(
                    padding: EdgeInsets.only(top: 3.h),
                    child: MyTextPoppines(
                      text: drawerList[index][1],
                      fontSize: height / MyFontSize.font14,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = context.screenHeight;
    final width = context.screenWidth;

    Future _logoutHandler() async {
      print("working");
      final notifier = context.read<AuthNotifier>();
      await notifier.logout(context);
    }

    return InkWell(
      onTap: () => _logoutHandler,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: AppColors.black.withOpacity(0.8),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3f000000),
              offset: Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: width / 6.8, vertical: 15.h),
        child: Row(
          children: [
            const Icon(
              Icons.logout_sharp,
              color: AppColors.white,
            ),
            10.hs,
            InkWell(
              onTap: () => _logoutHandler(),
              child: Padding(
                padding: EdgeInsets.only(top: 3.h),
                child: MyTextPoppines(
                  text: "Log Out",
                  fontSize: height / MyFontSize.font18,
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
