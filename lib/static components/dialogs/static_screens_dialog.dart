// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:new_user_side/resources/common/my_text.dart';

import '../../resources/common/buttons/my_buttons.dart';

class StaticScreensDialog extends StatefulWidget {
  String? title;
  String subtitle;
  StaticScreensDialog({
    Key? key,
    this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  State<StaticScreensDialog> createState() => _StaticScreensDialogState();
}

class _StaticScreensDialogState extends State<StaticScreensDialog> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      child: Container(
        // height:  widget.heightPercentage ?? size.height / 2.53,
        height: size.height * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          image: const DecorationImage(
            image: AssetImage("assets/images/dailog_bg.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 35.vs,
            // MyTextPoppines(
            //   text: widget.title ?? "",
            //   fontSize: size.height / 40,
            //   fontWeight: FontWeight.w500,
            //   maxLines: 3,
            //   height: 1.4,
            //   textAlign: TextAlign.center,
            // ),
            // 20.vs,
            MyTextPoppines(
              text: widget.subtitle,
              fontSize: size.height / 50,
              fontWeight: FontWeight.w500,
              maxLines: 9,
              height: 1.4,
              textAlign: TextAlign.center,
            ),
            // 30.vs,
            MyBlueButton(
              hPadding: size.width * 0.2,
              text: "OK",
              onTap: () => Navigator.pop(context),
            ),
            // 10.vs,
          ],
        ),
      ),
    );
  }
}
