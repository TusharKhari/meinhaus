// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:new_user_side/features/home/widget/project_img_card_widget.dart';
import 'package:new_user_side/res/common/buttons/my_buttons.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';
import '../../../provider/notifiers/estimate_notifier.dart';
import '../../ongoing projects/screens/multiple_onprojects_screen.dart';
import '../../ongoing projects/screens/ongoing_project_details_screen.dart';

class OngoingWorkCard extends StatelessWidget {
  final bool isMultiProjects;
  final int index;
  const OngoingWorkCard({
    Key? key,
    required this.isMultiProjects,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildOnProjectCard(
      context: context,
      isMultiProjectCard: isMultiProjects,
      index: index,
    );
  }

  Widget _buildOnProjectCard({
    required BuildContext context,
    required bool isMultiProjectCard,
    required int index,
  }) {
    final height = context.screenHeight;
    final width = context.screenWidth;
    final notifier = context.read<EstimateNotifier>();
    final projects = notifier.ongoingProjects.projects!;
    final project = projects[index];
    final isImgNull = project.projectImages!.length == 0;
    final projectId = project.services![0].projectId.toString();

    final proId = project.services![0].proId.toString();
    final isNormalProject = project.normal;

    _getProjectDetails() async {
      notifier.getProjectDetails(
        context: context,
        id: projectId,
        proId: proId,
      );
    }

    return Container(
      width: context.screenWidth / 1.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
      ),
      margin: EdgeInsets.only(right: width / 30),
      padding:
          EdgeInsets.symmetric(horizontal: width / 70, vertical: height / 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width / 35, vertical: height / 130),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextPoppines(
                  text: project.projectName.toString(),
                  fontWeight: FontWeight.w500,
                  fontSize: width / 30,
                ),
                Visibility(
                  visible: isMultiProjects,
                  child: 2.vspacing(context),
                ),
                Visibility(
                  visible: isMultiProjects,
                  child: MyTextPoppines(
                    text: "   +${project.services!.length} more services",
                    fontWeight: FontWeight.w500,
                    fontSize: width / 40,
                    color: AppColors.black.withOpacity(0.5),
                  ),
                ),
                Visibility(
                  visible: isMultiProjects,
                  child: 1.7.vspacing(context),
                ),
                Divider(
                  thickness: 1.0,
                  color: AppColors.grey.withOpacity(0.2),
                  height: height / 150,
                ),
                1.4.vspacing(context),
                // Estimated Date
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
                        text: project.estimateNo.toString(),
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
                Visibility(
                  visible: !isMultiProjects,
                  child: Row(
                    children: [
                      MyTextPoppines(
                        text: "Project Cost :",
                        fontWeight: FontWeight.w400,
                        fontSize: width / 38,
                      ),
                      10.hs,
                      MyTextPoppines(
                        text: "\$${project.projectCost}",
                        fontWeight: FontWeight.w600,
                        fontSize: width / 38,
                      ),
                    ],
                  ),
                ),
                Visibility(
                    visible: !isMultiProjects, child: 4.vspacing(context)),
                Row(
                  children: [
                    MyTextPoppines(
                      text: "Date Assigned :",
                      fontWeight: FontWeight.w400,
                      fontSize: width / 38,
                    ),
                    10.hs,
                    MyTextPoppines(
                      text: project.projectStartDate.toString(),
                      fontWeight: FontWeight.w600,
                      fontSize: width / 38,
                    ),
                    10.hs,
                  ],
                ),
                1.5.vspacing(context),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: width / 34),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
                image: isImgNull
                    ? DecorationImage(
                        image: AssetImage("assets/images/room/2(1).png"),
                        fit: BoxFit.cover,
                      )
                    : DecorationImage(
                        image: NetworkImage(
                            project.projectImages!.first.thumbnailUrl!),
                        fit: BoxFit.cover,
                      ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  3.vspacing(context),
                  MyTextPoppines(
                    text: "Project Photos:",
                    color: AppColors.white,
                    fontSize: width / 32,
                  ),
                  4.vspacing(context),
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
                  Expanded(flex: 1, child: 6.vspacing(context)),
                  Align(
                    alignment: Alignment.center,
                    child: MyBlueButton(
                      hPadding: width / 10,
                      vPadding: height / 120,
                      text: "View Est",
                      fontSize: width / 30,
                      fontWeight: FontWeight.w600,
                      onTap: () {
                        isMultiProjects
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return SubOngoingProjectScreen(
                                      index: index,
                                      projects: projects,
                                    );
                                  },
                                ),
                              )
                            : {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return OngoingProjectDetailScreen(
                                        id: projectId,
                                        isNormalProject: isNormalProject!,
                                      );
                                    },
                                  ),
                                ),
                                _getProjectDetails(),
                                print(
                                    "Project Details Id : $projectId || Pro Id : $proId"),
                              };
                      },
                    ),
                  ),
                  3.5.vspacing(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
