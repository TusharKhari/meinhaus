import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:new_user_side/provider/notifiers/auth_notifier.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';

class UserDeatilsToggleButton extends StatelessWidget {
  const UserDeatilsToggleButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toggle = Provider.of<AuthNotifier>(context);
    return FlutterSwitch(
      width: 55.w,
      height: 30.h,
      toggleSize: 20.sp,
      borderRadius: 20.r,
      value: toggle.isToggle,
      onToggle: (value) {
        toggle.setToggle(value);
      },
      activeToggleColor: AppColors.orange,
      // activeToggleColor: AppColors.black,
      inactiveToggleColor: AppColors.white,
      activeColor: Colors.transparent,
      activeSwitchBorder: Border.all(
      //  color: AppColors.black,
      color: AppColors.orange
      ),
    );
  }
}
