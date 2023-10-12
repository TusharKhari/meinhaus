

import 'package:flutter/material.dart';
 import 'package:new_user_side/resources/common/my_snake_bar.dart';
import 'package:new_user_side/static%20components/empty%20states/no_project/on_going_project%20_detail_static.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../features/home/widget/project_img_card_widget.dart';
import '../../../resources/common/buttons/my_buttons.dart';
import '../../../resources/common/my_text.dart';
import '../../../utils/constants/app_colors.dart';

class OngoingWorkCardStatic extends StatelessWidget {
   
  const OngoingWorkCardStatic({
    Key? key,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return SizedBox(
     height:  height / 2.90,
      child: _buildOnProjectCard(
        context: context,
        height: height, 
        width: width
      ),
    );
  }

  Widget _buildOnProjectCard({
    required BuildContext context,
    required double height, 
    required double width, 
  }) {
    void onViewEstTapped() async {
      // isMultiProjects
      //     ? Navigator.of(context).pushScreen(
      //         MultipleProjectServicesScreen(project: projects[index]),
      //       )
      //     : {
      //         await _getProjectDetails(),
      //         Navigator.of(context).pushScreen(
      //           OngoingProjectDetailScreen(serviceId: projectId),
      //         ),
      //       };
      // ("Project Id : $projectId || Pro Id : $proId").log();
       Navigator.of(context).pushScreen(
                OnGoingProjectDetailsStatic(),
              );
      // OnGoingProjectDetailsStatic
      showSnakeBarr(context, "Explore ongoing sample projects", SnackBarState.Info);
    }

    return 
    Container(
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
              horizontal: width / 35,
              vertical: height / 130,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // PROJECT NAME
                MyTextPoppines(
                //  text: project.projectName ?? "",
                text:  "Kitchen Repairing",
                  fontWeight: FontWeight.w500,
                  fontSize: width / 30,
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
                    text: "   +2 more services",
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
                      text: "\$100",
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
                //  isImgisNotNull
                //     ? DecorationImage(
                //         image: NetworkImage(
                //           project.projectImages!.first.thumbnailUrl!,
                //         ),
                //         fit: BoxFit.cover,
                //       )
                //     : 
                    DecorationImage(
                        image: AssetImage("assets/images/room/2(1).png"),
                        fit: BoxFit.cover,
                      ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height / 80),
                  MyTextPoppines(
                    text: "Project Photos:",
                    color: AppColors.white,
                    fontSize: width / 32,
                  ),
                  SizedBox(height: height / 80),
                  // Project Images
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ProjectImgCardWidget(
                        width: width / 8,
                        height: height / 16,
                        imgPath: "assets/images/room/2(1).png",
                      ),
                      ProjectImgCardWidget(
                        width: width / 8,
                        height: height / 16,
                        imgPath: "assets/images/room/room_3.png",
                      ),
                      Stack(
                        children: [
                          ProjectImgCardWidget(
                            width: width / 8,
                            height: height / 16,
                            imgPath: "assets/images/room/room_1.png",
                          ),
                          Positioned(
                            left: width / 30,
                            top: height / 90,
                            child: MyTextPoppines(
                              text: " +5\nMore",
                              fontSize: width / 36,
                              color: AppColors.white,
                            ),
                          ),
                        ],
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
                      hPadding: width / 10,
                      vPadding: height / 120,
                      text: "View Details",
                      fontSize: width / 30,
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