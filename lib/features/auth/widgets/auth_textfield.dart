// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

class AuthTextField extends StatefulWidget {
  final TextEditingController controller;
  final String headingText;
  final String hintText;
  final bool? isEmailField;
  final String? Function(String?)? validator;
  const AuthTextField({
    Key? key,
    required this.controller,
    required this.headingText,
    required this.hintText,
    this.isEmailField = true,
    required this.validator,
  }) : super(key: key);

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _showPasswod = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTextPoppines(
            text: "  ${widget.headingText}",
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          8.vs,
          TextFormField(
            controller: widget.controller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(
                  color: AppColors.black.withOpacity(0.15),
                  width: 1.5.w,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(
                  color: AppColors.black.withOpacity(0.15),
                  width: 1.5.w,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(
                  color: Colors.red.shade200,
                  width: 1.5.w,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(
                  color: Colors.red.shade200,
                  width: 1.5.w,
                ),
              ),
              hintText: "Enter you ${widget.hintText} here",
              hintStyle: TextStyle(
                fontSize: 16.sp,
                color: AppColors.grey.withOpacity(0.5),
              ),
              suffixIcon: widget.isEmailField!
                  ? Icon(
                      Icons.alternate_email_rounded,
                      color: AppColors.grey.withOpacity(0.7),
                    )
                  : InkWell(
                      onTap: () {
                        setState(() {
                          _showPasswod = !_showPasswod;
                        });
                      },
                      child: Icon(
                        _showPasswod
                            ? Icons.remove_red_eye_outlined
                            : CupertinoIcons.eye_slash,
                        color: AppColors.grey.withOpacity(0.7),
                      )),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15.w, vertical: 18.h),
            ),
            validator: widget.validator,
            obscureText: widget.isEmailField! ? false : _showPasswod,
          ),
        ],
      ),
    );
  }
}
