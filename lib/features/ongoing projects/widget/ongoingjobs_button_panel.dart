// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/features/chat%20with%20pro/screens/chat_with_pro_chat_list_screen.dart';
import 'package:new_user_side/features/customer%20support/screens/customer_support_send_query_screen.dart';
import 'package:new_user_side/provider/notifiers/estimate_notifier.dart';
import 'package:new_user_side/static%20componets/dialogs/pro_work_details_dialog.dart';
import 'package:new_user_side/static%20componets/dialogs/projects_notes_dialog.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../res/common/my_text.dart';
import '../../../utils/sizer.dart';
import '../../additional work/screens/add_addition_work_screen.dart';
import '../../additional work/widget/icon_button_with_text.dart';

class OngoingJobsButtonsPanel extends StatelessWidget {
  final bool isNormalProject;
  final String projectId;
  const OngoingJobsButtonsPanel({
    Key? key,
    required this.isNormalProject,
    required this.projectId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final estimateNotifer = context.read<EstimateNotifier>();
    final bookingId = estimateNotifer.projectDetails.services!.estimateNo;
    Future _getInvoiceHandler() async {
      final estimateNotifer = context.read<EstimateNotifier>();
      await estimateNotifer.progressInvoice(
        context: context,
        bookingId: bookingId.toString(),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIconButtonWithText(
            firstButtonText: "Customer Support",
            firstButtonTextColor: AppColors.black,
            firstButtonImgUrl: "assets/icons/support.png",
            firstButtonColor: const Color(0xFFEAEAEA),
            firstButtonOnTap: () {
              Navigator.pushNamed(context, SendQueryScreen.routeName);
              // showDialog(
              //   context: context,
              //   builder: (context) {
              //     return const CustomerSupportDialog();
              //   },
              // );
            },
            secondButtonext: "Project Notes",
            secondtButtonTextColor: AppColors.yellow,
            secondButtonImgUrl: "assets/icons/writing.png",
            secondButtonColor: const Color(0xFFFFF8EC),
            secondButtonOnTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return ProjectNotesDialog(
                    serviceId: projectId,
                  );
                },
              );
            },
          ),
          15.vs,
          _buildIconButtonWithText(
              firstButtonText: "Message pro",
              firstButtonTextColor: AppColors.buttonBlue,
              firstButtonImgUrl: "assets/icons/customer-support.png",
              firstButtonColor: const Color(0xFFE8F4FF),
              firstButtonOnTap: () => Navigator.pushNamed(
                  context, ChatWIthProChatListScreen.routeName),
              secondButtonext: isNormalProject
                  ? "Req Additional Work"
                  : "   Additional Work   ",
              secondtButtonTextColor: const Color(0xFFB9B100),
              secondButtonImgUrl: "assets/icons/add-photo.png",
              secondButtonColor: const Color(0xFFF7F6E0),
              secondButtonOnTap: isNormalProject
                  ? () {
                      Navigator.pushNamed(
                        context,
                        AddAdditionalWorkScreen.routeName,
                        arguments: projectId,
                      );
                      print("Project id For additonal work : $projectId");
                    }
                  : () {}),
          15.vs,
          Row(
            children: [
              InkWell(
                onTap: () => _getInvoiceHandler(),
                child: Container(
                  width: context.screenWidth / 3.2,
                  decoration: BoxDecoration(
                    color: Color(0xFF934600).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: Row(
                    children: [
                      Icon(
                        Icons.linked_camera_outlined,
                        size: 18.sp,
                        color: Color(0xFF934600),
                      ),
                      10.hs,
                      MyTextPoppines(
                        text: "Inovice",
                        height: 1.8,
                        fontSize: context.screenHeight / MyFontSize.font14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF934600),
                      ),
                    ],
                  ),
                ),
              ),
              10.hspacing(context),
              !isNormalProject
                  ? InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ProWorkDetailsDialog();
                          },
                        );
                      },
                      child: Container(
                        width: context.screenWidth / 2.4,
                        decoration: BoxDecoration(
                          color: Color(0xFFE0EAE4),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        child: Row(
                          children: [
                            Icon(
                              Icons.linked_camera_outlined,
                              size: 18.sp,
                              color: Color(0xFF004D1E),
                            ),
                            10.hs,
                            MyTextPoppines(
                              text: "Work Details",
                              height: 1.8,
                              fontSize:
                                  context.screenHeight / MyFontSize.font14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF004D1E),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButtonWithText({
    required String firstButtonText,
    required Color firstButtonTextColor,
    required String firstButtonImgUrl,
    required Color firstButtonColor,
    required VoidCallback firstButtonOnTap,
    required String secondButtonext,
    required Color secondtButtonTextColor,
    required String secondButtonImgUrl,
    required Color secondButtonColor,
    required VoidCallback secondButtonOnTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButtonWithText(
          text: firstButtonText,
          textColor: firstButtonTextColor,
          buttonColor: firstButtonColor,
          iconUrl: firstButtonImgUrl,
          isIcon: false,
          vPadding: 12.h,
          hPadding: 15.w,
          borderRadius: 20.r,
          onTap: firstButtonOnTap,
        ),
        IconButtonWithText(
          text: secondButtonext,
          textColor: secondtButtonTextColor,
          buttonColor: secondButtonColor,
          iconUrl: secondButtonImgUrl,
          isIcon: false,
          vPadding: 12.h,
          hPadding: 15.w,
          borderRadius: 20.r,
          onTap: secondButtonOnTap,
        ),
      ],
    );
  }
}
