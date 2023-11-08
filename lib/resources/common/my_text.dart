import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextPoppines extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final double? height;
  final int? maxLines;
  final TextAlign? textAlign;
  const MyTextPoppines({
    Key? key,
    required this.text,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.height,
    this.maxLines,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: fontSize ??16.sp,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontStyle: FontStyle.normal,
        color: color ?? Colors.black,
        height: height ?? (heights > 650 ? heights / 600 : heights / 600),
      ),
      textAlign: textAlign,
      maxLines: maxLines ?? 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
