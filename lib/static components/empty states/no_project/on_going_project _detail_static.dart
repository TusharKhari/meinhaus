

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:new_user_side/resources/common/my_app_bar.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../features/estimate/screens/estimate_generation_screen.dart';
import '../../../features/home/widget/project_img_card_widget.dart';
import '../../../resources/common/buttons/my_buttons.dart';
import '../../../resources/common/my_snake_bar.dart';
import '../../../resources/common/my_text.dart';
import '../../../utils/constants/app_colors.dart';

class OnGoingProjectDetailsStatic extends StatelessWidget {
  const OnGoingProjectDetailsStatic({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold
    (
      appBar: MyAppBar(text: "Sample Ongoing Projects"),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
               padding:   EdgeInsets.only(top: 20, left: 20,),
               child: Text(
                 'Here’s the list of your all ongoing projects.',
                 style: TextStyle(
                   color: Colors.black,
                   fontSize: 16,
                   fontFamily: 'Roboto',
                   fontWeight: FontWeight.w400,
                   height: 0,
                 ),
               ),
             ),
             Padding(
               padding: const EdgeInsets.only(left: 20,top: 20),
               child: SizedBox(
                
                 height:  height / 2.90,
                 child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                   return  _buildOnProjectCard(context: context, height: height, width: width, projectName: index==0 ? "Bathroom Renewal" : "Furniture Fixing");
                 },),
               ),
             ),
             Padding(
               padding: const EdgeInsets.only(top: 30, left: 20, bottom: 30),
               child: Text(
                 'Hourly Bookings',
                 style: TextStyle(
                   color: Colors.black,
                   fontSize: 16,
                   fontFamily: 'Roboto',
                   fontWeight: FontWeight.w400,
                   height: 0,
                 ),
               ),
             ),
             Padding(
               padding: const EdgeInsets.only(left: 20),
               child: SizedBox(
                height:  height / 2.90,
                child: _buildOnProjectCard(context: context, height: height, width: width, projectName: "Furniture Fixing")),
             ), 
          ],
        ),
      ),
    );
  }

  Widget _buildOnProjectCard({
    required BuildContext context,
    required double height, 
    required double width, 
    required String projectName, 
  }) {
    void onViewEstTapped() async { 
    //  showSnakeBarr(context, "No Ongoing Project Available", SnackBarState.Info);
       Navigator.of(context).pushScreen(
       EstimateGenerationScreen());
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
                text:  projectName,
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
                  visible: false,
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