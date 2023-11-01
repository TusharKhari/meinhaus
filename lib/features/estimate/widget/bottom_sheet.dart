
import 'package:flutter/material.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../resources/common/my_text.dart';
import '../../../utils/constants/app_colors.dart';

class BottomSheetSelectImagesOption extends StatelessWidget {
  final VoidCallback onTapCamera;
  final VoidCallback onTapGallery;
  const BottomSheetSelectImagesOption({
    Key? key,
     required this.onTapCamera,
    required this.onTapGallery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      height: height / 7.6,
      width: double.infinity,
      margin:
          EdgeInsets.symmetric(horizontal: width / 30, vertical: height / 90),
      padding: EdgeInsets.only(top: height / 50),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(width / 30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          
          _buildWorkers(
            context: context,
            backgroundColor: Colors.red,
            icon: Icons.camera_alt,
            title: "Camera",
            onTap: onTapCamera,
          ),
          _buildWorkers(
            context: context,
            backgroundColor: Colors.purple,
            icon: Icons.insert_photo,
            title: "Gallery",
            onTap: onTapGallery,
          ),
        ],
      ),
    );
  }
}

Widget _buildWorkers({
    required BuildContext context,
    required Color backgroundColor,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final height = context.screenHeight;
    final width = context.screenWidth;
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: width / 14,
            backgroundColor: backgroundColor,
            child: Icon(
              icon,
              size: width / 14,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: height / 160),
          MyTextPoppines(
            text: title,
            fontSize: width / 34,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
