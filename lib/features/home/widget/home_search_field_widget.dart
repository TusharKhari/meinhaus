// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';

class HomeSearchField extends StatefulWidget {
  const HomeSearchField({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeSearchField> createState() => _HomeSearchFieldState();
}

class _HomeSearchFieldState extends State<HomeSearchField> {
  TextEditingController searchController = TextEditingController();
  bool _isExpanded = false;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: height > 700
            ? 10.h
            : height > 600
                ? 13.h
                : 16.h,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: _isExpanded ? 170.w : 100.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.yellow),
        ),
        child: TextField(
          controller: searchController,
          style: TextStyle(fontSize: 14.sp),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 15.w),
            border: InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyle(
              color: AppColors.black.withOpacity(0.4),
              fontSize: 14.sp,
            ),
            suffixIcon: Icon(
              CupertinoIcons.search,
              color: AppColors.black.withOpacity(0.4),
              size: 18.sp,
            ),
          ),
          onSubmitted: (value) {
            setState(() {
              _isExpanded = false;
            });
          },
          onTap: () {
            setState(() {
              _isExpanded = true;
            });
          },
          onChanged: (value) {},
          cursorColor: AppColors.yellow,
        ),
      ),
    );
  }
}
