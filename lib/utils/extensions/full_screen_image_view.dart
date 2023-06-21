// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';

class FullScreenImageView extends StatefulWidget {
  final List<String> images;
  final int currentIndex;

  const FullScreenImageView(
      {Key? key, required this.images, required this.currentIndex})
      : super(key: key);

  @override
  _FullScreenImageViewState createState() => _FullScreenImageViewState();
}

class _FullScreenImageViewState extends State<FullScreenImageView> {
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    activeIndex = widget.currentIndex;
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: CarouselSlider.builder(
        options: CarouselOptions(
          height: double.infinity,
          viewportFraction: 1,
          initialPage: widget.currentIndex,
          enableInfiniteScroll: false,
          onPageChanged: (index, reason) {
            setState(() {
              activeIndex = index;
            });
          },
        ),
        itemCount: widget.images.length,
        itemBuilder: (context, index, realIndex) {
          final image = widget.images[index];
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.white.withOpacity(0.3),
        ),
        margin: EdgeInsets.symmetric(horizontal: 50.w, vertical: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 4.h),
        child: MyTextPoppines(
          text: "${activeIndex + 1}/${widget.images.length}",
          fontSize: 15.sp,
          color: AppColors.white,
          height: 1.6,
          fontWeight: FontWeight.w600,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
