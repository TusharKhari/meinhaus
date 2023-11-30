// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:new_user_side/resources/common/buttons/my_buttons.dart';
import 'package:new_user_side/features/home/screens/home_screen.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../resources/common/my_text.dart';
import '../../resources/font_size/font_size.dart';

class AdditionalWorkAddedDialog extends StatelessWidget {
  const AdditionalWorkAddedDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
        final size = MediaQuery.of(context).size;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 350.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          image: const DecorationImage(
            image: AssetImage("assets/images/dailog_bg.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
        child: Column(
          children: [
            35.vs,
            SizedBox(
              width: 85.w,
              height: 85.h,
              child:  
               SvgPicture.asset("assets/icons/done.svg"), 
            ),

            10.vs,
            SizedBox(
              width: 266.w,
              height: 60.h,
              child: Align(
                alignment: Alignment.center,
                child: MyTextPoppines(
                  text: "Additional Work has been requested successfully.",
                  fontSize: size.height * FontSize.sixteen,
                  fontWeight: FontWeight.w500,
                  maxLines: 3,
                  height: 1.3,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            20.vs,
            MyBlueButton(
              hPadding: 40.w,
              text: "Back To Home",
              onTap: () => Navigator.pushNamed(context, HomeScreen.routeName),
            ),
            20.vs,
          ],
        ),
      ),
    );
  }
}
