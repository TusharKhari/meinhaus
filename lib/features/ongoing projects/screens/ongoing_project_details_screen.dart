// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/features/pro%20profile/view/widget/pro_profile_widget.dart';
import 'package:new_user_side/features/review/widgets/show_review_card.dart';
import 'package:new_user_side/provider/notifiers/estimate_notifier.dart';
import 'package:new_user_side/res/common/my_app_bar.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../estimate/widget/download_pdf_card_widget.dart';
import '../widget/ongoing_project_bill_card_widget.dart';
import '../widget/ongoing_project_desc_card_widget.dart';
import '../widget/ongoing_project_photos_card_widget.dart';
import '../widget/ongoingjobs_button_panel.dart';

class OngoingProjectDetailScreen extends StatelessWidget {
  final String id;
  final bool isNormalProject;
  static const String routeName = '/ongoingProjectDeatils';
  const OngoingProjectDetailScreen({
    Key? key,
    required this.id,
    required this.isNormalProject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<EstimateNotifier>();
    final services = notifier.projectDetails.services;
    final String projectName =
        notifier.projectDetails.responseMessage.toString();
    final bool isProjetCompleted = projectName == "Hourly Project";

    return notifier.projectDetails.services != null &&
            notifier.proDetails.prodata != null
        ? ModalProgressHUD(
            inAsyncCall: notifier.loading,
            child: Scaffold(
              appBar: MyAppBar(text: projectName),
              body: Column(
                children: [
                  DownloadPdfCard(workName: services!.projectName.toString()),
                  6.vs,
                  Divider(thickness: 1.8.h, height: 0.0),
                  10.vs,
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              30.hs,
                              MyTextPoppines(
                                text: "Estimate  No :",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              20.hs,
                              MyTextPoppines(
                                text: services.estimateNo.toString(),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.yellow,
                              ),
                            ],
                          ),
                          Divider(thickness: 1.8.h),
                          10.vs,
                          const OngoingProjectBillCardWidget(),
                          10.vs,
                          Divider(thickness: 1.8.h),
                          10.vs,
                          const OngoingProjectDescCardWidget(),
                          Divider(thickness: 1.8.h),
                          10.vs,
                          const OngoingProjectPhotoCardWidget(),
                          20.vs,
                          Divider(thickness: 1.8.h),
                          OngoingJobsButtonsPanel(
                            isNormalProject: isNormalProject,
                            projectId: id,
                          ),
                          Visibility(
                            visible: isProjetCompleted,
                            child: Divider(thickness: 1.8.h),
                          ),
                          Visibility(
                            visible: isProjetCompleted,
                            child: ShowReviewCard(),
                          ),
                          Divider(thickness: 1.8.h),
                          ProProfileWidget(),
                          20.vs,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : ModalProgressHUD(inAsyncCall: notifier.loading, child: Scaffold());
  }
}
