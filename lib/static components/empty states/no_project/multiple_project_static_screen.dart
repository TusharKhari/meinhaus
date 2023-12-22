// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:new_user_side/resources/common/my_app_bar.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/constants/constant.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../provider/notifiers/estimate_notifier.dart';
import '../../../resources/font_size/font_size.dart';
import 'on_going_project _detail_static.dart';

class MultipleProjectServicesStaticScreen extends StatelessWidget {
  static const String routeName = '/multipleProjectServices';

  const MultipleProjectServicesStaticScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      "assets/static/1.png",
      "assets/static/2.png",
      "assets/static/3.png"
    ];
    List<Map<String, dynamic>> multipleProjects = [
      {
        "serviceCost": "1200",
        "estimateNo": "OD-18CM17",
        "startedOn": "22/11/23",
        "service": "Demolition",
        "proAssigned": "5",
        "projectCost": "6750",
        "description":
            "Remove all existing tiles, vanity and toilet. All lines capped where shutoff valves not existing, baseboards removed. All debris bagged and placed curbside for pickup. Junk removal available for extra fee",
        "projectPhotos": images,
      },
      {
        "serviceCost": "1850",
        "estimateNo": "OD-18CM17",
        "startedOn": "25/11/23",
        "service": "Plumbing",
        "proAssigned": "5",
        "projectCost": "6750",
        "description":
            " Renewal of all shut off valves inside washroom, Shower faucet to be replaced with new control cartridge. Shower drain to be roughed in for new center drain according to proposed shower dimensions. Finish Plumbing after tile.",
        "projectPhotos": images,
      },
      {
        "serviceCost": "2850",
        "estimateNo": "OD-18CM17",
        "startedOn": "25/11/23",
        "service": "Tiling",
        "proAssigned": "5",
        "projectCost": "6750",
        "description":
            "Complete waterproofing of washroom floors and shower walls, including tub surround using wonderboard and Redguard appropriately. Complete mesh/Tile mortar application with tile installation, grouting on all areas.",
        "projectPhotos": images,
      },
      {
        "serviceCost": "850",
        "estimateNo": "OD-18CM17",
        "startedOn": "25/11/23",
        "service": "Painting ans plastering",
        "proAssigned": "5",
        "projectCost": "6750",
        "description":
            "Drywall repairs anywhere necessary, installation of baseboards around finishes, complete prime and paint of walls, trim and ceilings of washroom. Caulking and filling of all trim.", "projectPhotos": images,
      },
    ];
    return Scaffold(
      appBar: MyAppBar(text: "Sample Ongoing projects"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeading(
              heading: "Washroom Renovation",
              totalServices: "4",
              context: context,
            ),
            1.vspacing(context),
            _MainCard(),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: multipleProjects.length,
              //project.services!.length,
              itemBuilder: (context, index) {
                return _ShowMultipleServicesCard(
                  project: multipleProjects[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeading({
    required String heading,
    required String totalServices,
    required BuildContext context,
  }) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w / 28, vertical: h / 78),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: w / 1.4,
            child: MyTextPoppines(
              text: heading,
              fontSize: h / 48.8,
              fontWeight: FontWeight.w600,
              maxLines: 2,
            ),
          ),
          MyTextPoppines(
            text: "$totalServices Services",
            fontSize: h / 52,
            fontWeight: FontWeight.w500,
            color: AppColors.black.withOpacity(0.6),
          ),
        ],
      ),
    );
  }
}

class _MainCard extends StatelessWidget {
  const _MainCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final projectCost = 5900;
    final isImgNull = 0 == 1;
    final size = MediaQuery.of(context).size;
    final images = [
      "assets/static/1.png",
      "assets/static/2.png",
      "assets/static/3.png"
    ];

    return Container(
      width: double.infinity,
      margin:
          EdgeInsets.symmetric(horizontal: width / 25, vertical: height / 80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
        boxShadow: boxShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                horizontal: width / 20, vertical: height / 90),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              color: Color(0xFFEDF6FF),
            ),
            child: Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2.3,
                      child: MyTextPoppines(
                        text: "Washroom Renovation",
                        fontSize: 18.sp,
                        // fontSize: width / 25,
                        fontWeight: FontWeight.w600,
                        maxLines: 9,
                      ),
                    ),
                    2.vspacing(context),
                    MyTextPoppines(
                      text: "( Include 4 Services)",
                      fontSize: size.height * FontSize.fourteen,
                      // fontSize: width / 38,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black.withOpacity(0.4),
                    ),
                  ],
                ),
                // Project Cost container
                Container(
                  width: width / 3.0,
                  margin: EdgeInsets.only(right: width / 40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.golden),
                    color: Color(0xFFFFFCF6),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      1.vspacing(context),
                      MyTextPoppines(
                        text: "Total Project Cost",
                        fontSize: size.height * FontSize.fourteen,
                        textAlign: TextAlign.center,
                        // fontSize: width / 36,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black.withOpacity(0.8),
                      ),
                      Divider(
                        thickness: 1,
                        height: 10,
                        color: AppColors.golden.withOpacity(0.6),
                      ),
                      MyTextPoppines(
                        text: "\$${projectCost}",
                        fontSize: size.height * FontSize.fourteen,
                        // fontSize: width / 36,
                        fontWeight: FontWeight.bold,
                        color: AppColors.golden,
                      ),
                      1.vspacing(context),
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(thickness: 1.0, height: 5.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                3.vspacing(context),
                // Booking Id
                Row(
                  children: [
                    MyTextPoppines(
                      text: "Booking ID :",
                      fontSize: size.height * FontSize.fifteen,
                      // fontSize: headline1,
                      fontWeight: FontWeight.w600,
                    ),
                    5.hspacing(context),
                    MyTextPoppines(
                      text: "OD-18V45",
                      fontSize: size.height * FontSize.fifteen,
                      // fontSize: headline1,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black.withOpacity(0.6),
                    ),
                  ],
                ),
                5.vspacing(context),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextPoppines(
                      text: "Description :",
                      fontSize: size.height * FontSize.fifteen,
                      // fontSize: size.height * FontSize.fifteen,
                      // fontSize: headline1,
                      fontWeight: FontWeight.w600,
                    ),
                    5.hspacing(context),
                    SizedBox(
                      width: width * 0.46,
                      // width: 200.w,
                      child: MyTextPoppines(
                        text:
                            "Redo Complete washroom, including tile floors, new vanity, new toilet, Complete tub surround and related tiling. Baseboards to be installed, waterproofing of all shower and tub walls using concrete board & membranes as necessary.",
                        fontSize: size.height * FontSize.fourteen,
                        // fontSize: width / 40,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black.withOpacity(0.4),
                        maxLines: 100,
                      ),
                    ),
                  ],
                ),
                5.vspacing(context),
                // Photos
                MyTextPoppines(
                  text: "Photos",
                  fontSize: size.height * FontSize.fifteen,
                  // fontSize: headline1,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black.withOpacity(0.8),
                ),
                3.vspacing(context),
                isImgNull
                    ? MyTextPoppines(
                        text: "     No Img uploaded yet",
                        fontSize: size.height * FontSize.sixteen,
                        // fontSize: headline1,
                        fontWeight: FontWeight.w600,
                        color: AppColors.buttonBlue.withOpacity(0.8),
                      )
                    : SizedBox(
                        height: height / 9,
                        width: width / 1.2,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.zero,
                          itemCount: images.length,
                          // itemCount: project.projectImages!.length,
                          itemBuilder: (context, index) {
                            // final images = project.projectImages![index];
                            return Container(
                              margin: EdgeInsets.only(right: width / 30),
                              width: width / 4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.golden,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  images[index],
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
          5.vspacing(context),
        ],
      ),
    );
  }
}

class _ShowMultipleServicesCard extends StatelessWidget {
  final Map<String, dynamic> project;
  const _ShowMultipleServicesCard({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final headline1 = size.height * FontSize.sixteen;
    final projectId = project["estimateNO"];
    final proId = project["proAssigned"];
    final isProAssigned = proId != "null";

    _getProjectDetails() {
      final notifier = context.read<EstimateNotifier>();
      notifier.getProjectDetails(context: context, id: projectId, proId: proId);
    }

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: width / 25,
        vertical: height / 80,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
        boxShadow: boxShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: width / 20,
              vertical: height / 80,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              color: Color(0xFFEDF6FF),
            ),
            child: MyTextPoppines(
              text: project["service"],
              // text: "project",
              fontSize: size.height * FontSize.sixteen,
              fontWeight: FontWeight.w600,
            ),
          ),
          Divider(thickness: 1.0, height: 5.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 25),
            child: Column(
              children: [
                3.vspacing(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Assigned date
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            MyTextPoppines(
                              text: "Date Assigned :  ",
                              fontSize: headline1,
                              fontWeight: FontWeight.w500,
                            ),
                            MyTextPoppines(
                              text: project["startedOn"],
                              // text: service.dateAssigned.toString(),
                              fontSize: headline1,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black.withOpacity(0.4),
                            ),
                          ],
                        ),
                        4.vspacing(context),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyTextPoppines(
                              text: "Pro Assigned :  ",
                              fontSize: headline1,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(
                              width: width / 4,
                              child: MyTextPoppines(
                                text: isProAssigned
                                    ? proId
                                    : "No Pro Assigned yet..",
                                fontSize: headline1,
                                fontWeight: FontWeight.w600,
                                color: isProAssigned
                                    ? AppColors.black.withOpacity(0.4)
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Project Cost
                    Container(
                      width: 90.w,
                      margin: EdgeInsets.only(right: width / 40),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(width: 0.5, color: AppColors.golden),
                        color: AppColors.golden.withOpacity(0.05),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          1.vspacing(context),
                          MyTextPoppines(
                            text: "Service Cost",
                            fontSize: headline1,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black.withOpacity(0.8),
                          ),
                          Divider(
                            thickness: 1,
                            height: 10,
                            color: AppColors.golden.withOpacity(0.6),
                          ),
                          MyTextPoppines(
                            text: project["serviceCost"],
                            fontSize: headline1,
                            fontWeight: FontWeight.bold,
                            color: AppColors.golden,
                          ),
                          1.vspacing(context),
                        ],
                      ),
                    )
                  ],
                ),
                2.vspacing(context),
                Divider(thickness: 1.0),
                2.vspacing(context),
                isProAssigned
                    ? InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OnGoingProjectDetailsStatic(
                              project: project,
                            ),
                          ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              width: 1.5.w,
                              color: AppColors.textBlue1E9BD0,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: size.height * FontSize.sixteen,
                            vertical: height / 100,
                          ),
                          child: MyTextPoppines(
                            text: "View Details",
                            fontWeight: FontWeight.w600,
                            color: AppColors.buttonBlue,
                            fontSize: headline1,
                          ),
                        ),
                      )
                    : SizedBox(),
                4.vspacing(context)
              ],
            ),
          )
        ],
      ),
    );
  }
}
