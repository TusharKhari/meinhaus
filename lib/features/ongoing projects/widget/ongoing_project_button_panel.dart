// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_user_side/data/models/conversation_list_model.dart';
 import 'package:new_user_side/features/chat/screen/chatting_screen.dart';
import 'package:new_user_side/features/customer%20support/screens/customer_support_send_query_screen.dart';
import 'package:new_user_side/features/project%20notes/view/screens/project_notes_screen.dart';

import 'package:new_user_side/provider/notifiers/estimate_notifier.dart';
import 'package:new_user_side/provider/notifiers/support_notifier.dart';
 import 'package:new_user_side/static%20components/dialogs/projects_notes_dialog.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../provider/notifiers/additional_work_notifier.dart';
import '../../../provider/notifiers/saved_notes_notifier.dart';
import '../../../resources/common/my_text.dart';
import '../../additional work/screens/add_addition_work_screen.dart';
import '../../additional work/screens/additional_work_from_pro_screen.dart';
import '../../additional work/widget/icon_button_with_text.dart';
import '../../invoice/screens/progess_invoice_screen.dart';

class OngoingJobsButtonsPanel extends StatelessWidget {
  const OngoingJobsButtonsPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    final supportNotifier = context.watch<SupportNotifier>();
    final estimateNotifer = context.read<EstimateNotifier>();
    final project = estimateNotifer.projectDetails.services!;
    final isSupportActive = supportNotifier.supportStatus == 1;
    final bookingId = project.estimateNo;
     final projectId = project.projectId.toString();
    final isProjectCompleted = project.isCompleted!;
    final invoice = estimateNotifer.progressInvoiceModel.data;
    final totalDueAmount = invoice?.amountToBePaid!.totalAmountDue!.split(".");
    final bool amountPaid = totalDueAmount?[0] == "0";
    final String invoicePaidOrPay = amountPaid ? "Paid" : "Pay";
    
    // get invoice data
    void _getInvoiceHandler() {
      final estimateNotifer = context.read<EstimateNotifier>();
      Navigator.of(context).pushScreen(ProgressInvoiceScreen());
      estimateNotifer.progressInvoice(
        context: context,
        bookingId: bookingId!,
      );
    }

    // Getting all the additional work requested by user
    _getAdditionalWorkHandler() async {
      final notifier = context.read<AdditionalWorkNotifier>();
      await notifier.getAdditonalWork(
        context: context,
        projectId: projectId,
      );
    }

    // To get all the saved notes
    _getSavedNotesHandler() async {
      final notifer = context.read<SavedNotesNotifier>();
      await notifer.getSavedNotes(context: context, id: projectId);
      Navigator.of(context).pushScreen(SavedNotesScreen());
    }

    // onTap Customer Button
    _onTapCustomerButton() {
      isSupportActive
          ? Navigator.of(context).pushScreen(
              ChattingScreen(
                isChatWithPro: false,
                estimateId: project.projectId.toString(),
              ),
            )
          : Navigator.of(context).pushNamed(
              SendQueryScreen.routeName,
            );
    }

    // onTap Project Notes
    _onTapProjectNotesButton() {
      isProjectCompleted
          ? _getSavedNotesHandler()
          : showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return ProjectNotesDialog(
                  serviceId: projectId,
                );
              },
            );
    }

    // Navigate to chatting screen
    void onMessageProTapped() async {
      final projectNotifer =
          context.read<EstimateNotifier>().projectDetails.services;
      final proNotifier = context.read<EstimateNotifier>().proDetails.prodata;
      Navigator.of(context).pushScreen(
        ChattingScreen(
          isChatWithPro: true,
          sendUserId: proNotifier!.proId,
          estimateId: projectNotifer!.projectId.toString(),
          conversations: Conversations(
            profilePicture: proNotifier.proProfileUrl,
            toUserName: proNotifier.proName,
            projectName: projectNotifer.projectName,
            estimateBookingId: projectNotifer.estimateNo,
            projectStartedOn: projectNotifer.projectStartDate,
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 20.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ============
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Customer Support Button
              Expanded(
                child: Stack(
                  children: [
                    InkWell(
                      onTap: _onTapCustomerButton,
                      child: Container(
                        //  width: w / 2.15,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAEAEA),
                          borderRadius: BorderRadius.circular(w / 12),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 10.h,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/project_detail/customer_support.svg",
                              height: h * 0.02,
                            ),
                            SizedBox(width: w / 40),
                            MyTextPoppines(
                              text: "Customer Support",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // WWhen support is active we will show a active status
                    isSupportActive
                        ? Positioned(
                            right: w / 200000,
                            child: CircleAvatar(
                              radius: w / 60,
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 255, 106),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
              // Spacer(),
              SizedBox(
                width: 10.w,
              ),
              // Project Notes Button
              Expanded(
                child: InkWell(
                  onTap: _onTapProjectNotesButton,
                  child: Container(
                    // width: double.maxFinite,
                    // height: h / 16,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8EC),
                      borderRadius: BorderRadius.circular(w / 12),
                    ),
                    padding: EdgeInsets.symmetric(
                      // horizontal: w / 35,
                      vertical: 10.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/project_detail/project_notes.svg",
                          height: h * 0.02,
                        ),
                        SizedBox(width: w / 40),
                        MyTextPoppines(
                          text: "Project Notes",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.yellow,
                          //
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          15.vs,
          // Message pro and Request additional work

          _buildIconButtonWithText(
              firstButtonText: "Message pro",
              firstButtonTextColor: AppColors.buttonBlue,
              firstButtonImgUrl: "assets/project_detail/message_pro.svg",
              firstButtonColor: const Color(0xFFE8F4FF),
              firstButtonOnTap: () => onMessageProTapped(),
              secondButtonext:
                  // isProjectCompleted
                  //     ? "   Additional Work   "
                  //     : "Req Additional Work",
                  "Invoice",
                  // "Invoice($invoicePaidOrPay)",
              secondtButtonTextColor: const Color(0xFF934600),
              // secondButtonImgUrl: "assets/project_detail/work_details.svg",
              secondButtonImgUrl: "assets/project_detail/invoice 1.svg",
              secondButtonColor: const Color(0xFF934600).withOpacity(0.12),
              secondButtonOnTap: () {
                _getInvoiceHandler();
              }),

//
          15.vs,

          InkWell(
            onTap: !isProjectCompleted
                ? () {
                    Navigator.pushNamed(
                      context,
                      AddAdditionalWorkScreen.routeName,
                      arguments: projectId,
                    );
                    //   print("Project id For additional work : $projectId");
                  }
                : () {
                    // Show history of all the requested additional work
                    _getAdditionalWorkHandler();
                    Navigator.of(context).pushScreen(
                      AdditionalWorkProProvideScreen(),
                    );
                  },
            child: Container(
              // width: context.screenWidth / 3.2,
              decoration: BoxDecoration(
                color: Color(0xFFF7F6E0),
                borderRadius: BorderRadius.circular(30.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/project_detail/work_details.svg"),
                  SizedBox(width: w / 40),
                  MyTextPoppines(
                    text: isProjectCompleted
                        ? "   Additional Work   "
                        : "Req Additional Work",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFB9B100),
                  ),
                ],
              ),
            ),
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
      //  mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: IconButtonWithText(
            text: firstButtonText,
            textColor: firstButtonTextColor,
            buttonColor: firstButtonColor,
            iconUrl: firstButtonImgUrl,
            isIcon: false,
            vPadding: 12.h,
            hPadding: 2.w,
            borderRadius: 20.r,
            onTap: firstButtonOnTap,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: IconButtonWithText(
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
        ),
      ],
    );
  }
}
