import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:new_user_side/static%20components/empty%20states/no_project/on_going_project%20_detail_static.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import '../../../features/home/widget/project_img_card_widget.dart';
import '../../../resources/common/buttons/my_buttons.dart';
import '../../../resources/common/my_text.dart';
import '../../../resources/font_size/font_size.dart';
import '../../../utils/constants/app_colors.dart';
import '../../dialogs/static_screens_dialog.dart';
import 'multiple_project_static_screen.dart';

class OngoingWorkCardStatic extends StatelessWidget {
  const OngoingWorkCardStatic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    final size = MediaQuery.of(context).size;
      final height = size.height;
    final width = size.width;

    return SizedBox(
      height: height / 2.90,
      child: _buildOnProjectCard(
        context: context,
        height: height,
        width: width,
        size: size,
      ),
    );
  }

  Widget _buildOnProjectCard({
    required BuildContext context,
    required double height,
    required double width,
    required Size size,
  }) {
    void onViewEstTapped() async { 

      Navigator.of(context).pushScreen(
        // OnGoingProjectDetailsStatic(),
        MultipleProjectServicesStaticScreen(), 
      );

      // OnGoingProjectDetailsStatic
      //showSnakeBarr(context, "This is a sample project", SnackBarState.Info);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => StaticScreensDialog(
          subtitle:
             "This is a sample project where you can tour all the functions we provide for an ongoing project.",),
      );
    }

    return Container(
      width: context.screenWidth / 1.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
      ),
      margin: EdgeInsets.only(right: width / 30),
      padding: EdgeInsets.symmetric(
        horizontal: width / 70,
        vertical: height / 200,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width / 36,
              vertical: height / 130,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // PROJECT NAME
                MyTextPoppines(
                  //  text: project.projectName ?? "",
                  text: "Washroom Renewal Project",
                  fontWeight: FontWeight.w500,
                  fontSize: size.height * FontSize.sixteen,
                  maxLines: 1,
                ),
                Visibility(
                  visible: true,
                  // visible: isMultiProjects,
                  child: SizedBox(height: height / 150),
                ),
                // TOTAL SERVICES COUNT
                Visibility(
                  visible: true,
                  // visible: isMultiProjects,
                  child: MyTextPoppines(
                    text: " +3 more services",
                    //  text: "   +${project.services!.length} more services",
                    fontWeight: FontWeight.w500,
                    fontSize: width / 40,
                    color: AppColors.black.withOpacity(0.5),
                  ),
                ),
                Visibility(
                  visible: false,
                  child: SizedBox(height: height / 150),
                ),
                Divider(
                  thickness: 1.0,
                  color: AppColors.grey.withOpacity(0.2),
                  height: height / 150,
                ),
                SizedBox(height: height / 140),
                // ESTIMSTE BOOKING ID
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppColors.yellow.withOpacity(0.1),
                  ),
                  padding: EdgeInsets.symmetric(vertical: height / 160),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MyTextPoppines(
                        text: "Booking ID : ",
                        fontSize: width / 38,
                        fontWeight: FontWeight.w500,
                      ),
                      MyTextPoppines(
                        //  text: project.estimateNo,
                        text: "OD-058699S",
                        fontSize: width / 38,
                        fontWeight: FontWeight.w600,
                        color: AppColors.yellow,
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.0,
                  color: AppColors.grey.withOpacity(0.2),
                  height: height / 50,
                ),
                // PROJECT COST
                Visibility(
                  // visible: !isMultiProjects,
                  visible: true,
                  child: Row(
                    children: [
                      MyTextPoppines(
                        text: "Project Cost :",
                        fontWeight: FontWeight.w400,
                        fontSize: width / 38,
                      ),
                      10.hs,
                      MyTextPoppines(
                        //  text: "${project.projectCost}",
                        text: "\$2938",
                        fontWeight: FontWeight.w600,
                        fontSize: width / 38,
                      ),
                    ],
                  ),
                ),
                Visibility(
                  // visible: !isMultiProjects,
                  visible: true,
                  child: SizedBox(height: height / 120),
                ),
                Row(
                  children: [
                    MyTextPoppines(
                      text: "Date Assigned :",
                      fontWeight: FontWeight.w400,
                      fontSize: width / 38,
                    ),
                    SizedBox(width: width / 60),
                    MyTextPoppines(
                      //   text: project.projectStartDate ?? "",
                      text: "01/01/2023",
                      fontWeight: FontWeight.w600,
                      fontSize: width / 38,
                    ),
                  ],
                ),
                // SizedBox(height: height / 135),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: width / 34),
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                image: 
                    DecorationImage(
                  image: AssetImage("assets/static/1.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
             //     SizedBox(height: height / 80),
                  MyTextPoppines(
                    text: "Project Photos:",
                    color: AppColors.white,
                    fontSize: width / 32,
                  ),
                 // SizedBox(height: height / 80),
                  // Project Images
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                       ProjectImgCardWidget(
                      width: width / 8,
                      height: height / 16,
                      imgPath:"assets/static/2.png",
                    ),
                    ProjectImgCardWidget(
                      width: width / 8,
                      height: height / 16,
                      imgPath:"assets/static/3.png",
                    ),
                      
                    ],
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(height: height / 80),
                  ),
                  // View Estimate Button
                  Align(
                    alignment: Alignment.center,
                    child: MyBlueButton(
                      hPadding: 10.w,
                      vPadding: height / 120,
                      fontSize: size.height * FontSize.fourteen,
                      text: "View Project",
                      fontWeight: FontWeight.w600,
                      onTap: onViewEstTapped,
                    ),
                  ),
                  SizedBox(height: height / 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
