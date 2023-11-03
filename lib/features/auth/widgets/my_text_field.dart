import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

class MyTextField extends StatefulWidget {
  final String text;
  final bool? isSuffix;
  final int? maxLines;
  final double? width;
  final String? hintText;
  final bool? isHs20;
  final FontWeight? headingFontWeight;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final Function(String)? onSubmit;

  const MyTextField({
    Key? key,
    required this.text,
    this.isSuffix = false,
    this.maxLines = 1,
    this.width,
    this.hintText = '',
    this.isHs20 = true,
    this.headingFontWeight,
    this.controller,
    this.validator,
    this.focusNode,
    this.onSubmit,
  }) : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.isHs20! ? 25.w : 0.w,
        vertical: 10.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTextPoppines(
            text: " ${widget.text}",
            fontWeight: widget.headingFontWeight ?? FontWeight.w600,
            fontSize: width / 28,
            maxLines: 1,
          ),
          3.vspacing(context),
          Container(
            width: widget.width ?? double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: TextFormField(
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              controller: widget.controller,
              maxLines: widget.maxLines,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(194, 240, 240, 240),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: width / 26,
                  vertical: widget.isSuffix!
                      ? 14.h
                      : widget.maxLines == 1
                          ? 0
                          : height / 80,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(
                    color: Colors.blue.shade400,
                    width: 1.5.w,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(
                    color: Colors.red.shade300,
                    width: 1.5.w,
                  ),
                ),
                suffixIcon: widget.isSuffix!
                    ? InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.date_range_outlined,
                          color: AppColors.black,
                          size: 25.sp,
                        ),
                      )
                    : null,
                hintText: widget.hintText,
                hintStyle: GoogleFonts.poppins(
                  color: AppColors.black.withOpacity(0.5),
                  fontSize: width / 36,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
              style: GoogleFonts.poppins(
                color: AppColors.black,
                fontSize: width / 36,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
              validator: widget.validator,
              focusNode: widget.focusNode,
              onFieldSubmitted: widget.onSubmit,
            ),
          ),
        ],
      ),
    );
  }
}
