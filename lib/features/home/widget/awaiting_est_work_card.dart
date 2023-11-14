import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../provider/notifiers/estimate_notifier.dart';
import '../../../resources/common/buttons/my_buttons.dart';
import '../../../resources/common/my_text.dart';
import '../../../utils/constants/app_colors.dart';
import 'project_img_card_widget.dart';

class AwaitingEstimateWorkCard extends StatelessWidget {
  final int index;

  AwaitingEstimateWorkCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final getEstProvider = context.watch<EstimateNotifier>();
    final projectDetails = getEstProvider.estimated.awaitingEstimate![index];

    return Container(
      width: width / 2,
      margin: EdgeInsets.only(right: 16.sp),
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
                  text: projectDetails.title.toString(),
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
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
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      MyTextPoppines(
                        text: projectDetails.createdAt!.substring(0, 10),
                        fontSize: 11.sp,
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
              vertical: height / 150,
            ),
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(width / 40),
                bottomRight: Radius.circular(width / 40),
              ),
              // BACKGROUND PROJECT IMAGE
              image: projectDetails.uploadedImgs != null &&
                      projectDetails.uploadedImgs!.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(
                        projectDetails.uploadedImgs!.first.thumbnailUrl!,
                      ),
                      fit: BoxFit.fill,
                    )
                  : DecorationImage(
                      image: AssetImage("assets/images/room/2(1).png"),
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
                    projectDetails.uploadedImgs!.length >= 1
                        ? ProjectImgCardWidget(
                            width: width / 8,
                            height: height / 16,
                            isNetworkImg: true,
                            //imgPath: "assets/images/room/2(1).png",
                            //  projectDetails.uploadedImgs
                            imgPath:
                                projectDetails.uploadedImgs![0].thumbnailUrl!,
                          )
                        : ProjectImgCardWidget(
                            width: width / 8,
                            height: height / 16,
                            imgPath: "assets/images/room/2(1).png",
                          ),
                    projectDetails.uploadedImgs!.length >= 2
                        ? ProjectImgCardWidget(
                            width: width / 8,
                            height: height / 16,
                            isNetworkImg: true,
                            imgPath:
                                projectDetails.uploadedImgs![1].thumbnailUrl!,
                          )
                        : ProjectImgCardWidget(
                            width: width / 8,
                            height: height / 16,
                            imgPath: "assets/images/room/room_3.png",
                          ),
                    Stack(
                      children: [
                        projectDetails.uploadedImgs!.length >= 3
                            ? ProjectImgCardWidget(
                                width: width / 8,
                                height: height / 16,
                                isNetworkImg: true,
                                imgPath: projectDetails
                                    .uploadedImgs![2].thumbnailUrl!,
                              )
                            : ProjectImgCardWidget(
                                width: width / 8,
                                height: height / 16,
                                imgPath: "assets/images/room/room_1.png",
                              ),
                        Positioned(
                          left: width / 30,
                          top: height / 60,
                          child: MyTextPoppines(
                            // text: " +5\nMore",!
                            text: projectDetails.uploadedImgs!.length > 3
                                ? " +${(projectDetails.uploadedImgs!.length - 3)} \nMore"
                                : " ",
                            fontSize: width / 38,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: height / 60),
                // ESTIMATE COST
                MyTextPoppines(
                  text: "",
                  // text: "Estimated Amount: \$${projectCost}",
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
                  child:
                  //  MyBlueButton(
                  //   hPadding: 10.w,
                  //   vPadding: height / 120,
                  //   fontSize: 14.sp,
                  //   text: "Awaiting",
                  //   fontWeight: FontWeight.w600,
                  //   onTap: () {
                  //     // Navigator.pushNamed(
                  //     //   context,
                  //     // //  EstimatedWorkDetailScreen.routeName,
                  //     //   arguments: index,
                  //     // );
                  //   },
                  // ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                  decoration: BoxDecoration(
                  border: Border.all(width: 2.w, color: AppColors.golden),
                  borderRadius: BorderRadius.circular(10.r) , 
                  color: Colors.grey 
                  ),
                  child: Text("Awaiting", style: TextStyle(
                    color: AppColors.white, 
                    fontSize: 18.sp, 
                    fontWeight: FontWeight.w600
                  ),),
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
