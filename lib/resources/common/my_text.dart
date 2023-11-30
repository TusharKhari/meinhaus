import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../font_size/font_size.dart';

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
    final size = MediaQuery.of(context).size;
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: fontSize ??size.height * FontSize.sixteen,
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
