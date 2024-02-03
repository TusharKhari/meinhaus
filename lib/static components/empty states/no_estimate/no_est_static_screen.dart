// when no estimation is present in data

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 
import '../../../features/home/widget/project_img_card_widget.dart';
import '../../../resources/common/buttons/my_buttons.dart';
import '../../../resources/common/my_text.dart';
import '../../../resources/font_size/font_size.dart';
import '../../../utils/constants/app_colors.dart';
import '../../dialogs/static_screens_dialog.dart';
import 'no_est_work_detail_static_screen.dart';

class NoEstStaticScreen extends StatelessWidget {
  const NoEstStaticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final size = MediaQuery.of(context).size;

    return Container(
      width: width / 2,
      margin: EdgeInsets.only(right: width / 36),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width / 28),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: width / 34),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height / 60),
                // PROJECT NAME
                MyTextPoppines(
                  // text: projectDetails.projectName.toString(),
                  text: "Washroom Renewal Project",
                  fontWeight: FontWeight.w500,
                  fontSize: size.height * FontSize.sixteen,
                  maxLines: 1,
                ),
                Divider(thickness: 1.0, color: AppColors.grey.withOpacity(0.2)),
                // ESTIMATE DATE
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width / 70),
                  padding: EdgeInsets.symmetric(vertical: height / 150),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width / 70),
                    color: AppColors.yellow.withOpacity(0.1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MyTextPoppines(
                        text: "Estimate Date :",
                        fontSize: width / 38,
                        fontWeight: FontWeight.w500,
                      ),
                      MyTextPoppines(
                        text: "01/01/23",
                        // text: projectDetails.estimateDate ?? "",
                        fontSize: width / 38,
                        fontWeight: FontWeight.w600,
                        color: AppColors.yellow,
                      ),
                    ],
                  ),
                ),
                Divider(thickness: 1.0, color: AppColors.grey.withOpacity(0.2)),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              right: width / 65,
              left: width / 65,
              bottom: height / 300,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: width / 36,
              vertical: height / 80,
            ),
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(width / 40),
                bottomRight: Radius.circular(width / 40),
              ),
              // BACKGROUND PROJECT IMAGE
              image: DecorationImage(
                image: AssetImage("assets/static/demoilation_user_uploaded.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextPoppines(
                  text: "Photos:",
                  color: AppColors.white,
                  fontSize: width / 36,
                ),
                SizedBox(height: height / 60),
                // Project Images
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ProjectImgCardWidget(
                      width: width / 8,
                      height: height / 16,
                      imgPath:"assets/static/plumbing_user_uploaded.png",
                    ),
                    ProjectImgCardWidget(
                      width: width / 8,
                      height: height / 16,
                      imgPath:"assets/static/tiling_user_uploaded.png",
                    ),
                    
                  ],
                ),
                SizedBox(height: height / 60),
                // ESTIMATE COST
                MyTextPoppines(
                  text: "Estimated Amount: \$2600",
                  fontSize: width / 36,
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                  maxLines: 1,
                ),
                SizedBox(height: height / 120),
                Divider(
                  thickness: 1,
                  color: AppColors.white.withOpacity(0.8),
                  height: 0,
                ),
                SizedBox(height: height / 120),
                Align(
                  alignment: Alignment.center,
                  child: MyBlueButton(
                    hPadding: 10.w,
                    vPadding: height / 120,
                    text: "View Quote",
                    fontSize: size.height * FontSize.fourteen,
                    fontWeight: FontWeight.w600,
                    onTap: () {
                      // showSnakeBarr(context, "This is a sample estimate",
                      //     SnackBarState.Info);
                      Navigator.pushNamed(
                        context,
                        NoEstWorkDetailStaticScreen.routeName,
                        //   EstimatedWorkDetailScreen.routeName,
                      );
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => StaticScreensDialog(
                          subtitle: "This is a sample estimate for demonstration purposes. When you create a real estimate, this will disappear."),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
