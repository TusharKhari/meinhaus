// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/res/common/show_img_upload_option.dart';
import 'package:provider/provider.dart';

import 'package:new_user_side/res/common/my_app_bar.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/features/check%20out/screens/checkout_screen.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../provider/notifiers/estimate_notifier.dart';
import '../../../res/common/buttons/my_bottom_bar_button.dart';

import '../widget/download_pdf_card_widget.dart';
import '../widget/estimate_carousel_img.dart';
import '../widget/estimated_work_bill_card_widget.dart';
import '../widget/project_billing_card_widget.dart';
import '../widget/project_estimated_card_widget.dart';

class EstimatedWorkDetailScreen extends StatelessWidget {
  static const String routeName = '/estimatedwork';
  const EstimatedWorkDetailScreen({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final getEstProvider = context.read<EstimateNotifier>();
    final projectDetails = getEstProvider.estimated.estimatedWorks![index];
    final bookingId = projectDetails.estimateId;
    final amountToPay = projectDetails.projectBilling!.totalDepositAmount;
    final bool isImgPresent = projectDetails.uploadedImgs!.length > 0;

    return Scaffold(
      appBar: MyAppBar(text: "Estimated Work"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DownloadPdfCard(workName: projectDetails.projectName.toString()),
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
                        fontSize: h / 65,
                        fontWeight: FontWeight.w600,
                      ),
                      20.hs,
                      MyTextPoppines(
                        text: projectDetails.estimateId.toString(),
                        fontSize: h / 65,
                        fontWeight: FontWeight.w400,
                        color: AppColors.yellow,
                      ),
                    ],
                  ),
                  Divider(thickness: 1.8.h),
                  10.vs,
                  EstimatedWorkBillCardWidget(index: index),
                  20.vs,
                  Divider(thickness: 1.8.h),
                  20.vs,
                  _buildSubHeadlines(
                    context: context,
                    subHeadline: "Project Estimate :",
                  ),
                  ProjectEstimatedCardWidget(index: index),
                  3.vspacing(context),
                  Visibility(
                    visible: isImgPresent,
                    child: _buildSubHeadlines(
                      context: context,
                      subHeadline: "Uploaded Photos :",
                    ),
                  ),
                  15.vs,
                  isImgPresent
                      ? EstimateCarouselImg(index: index)
                      : ShowImgUploadOption(bookingId: bookingId!),
                  20.vs,
                  _buildSubHeadlines(
                    context: context,
                    subHeadline: "Project Billing :",
                  ),
                  15.vs,
                  ProjectBillingCardWidget(index: index)
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavWidget(
        hPadding: MediaQuery.of(context).size.width / 7.6,
        text: "Book Project",
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CheckOutScreen(
                  ProjectName: projectDetails.projectName.toString(),
                  bookingId: bookingId.toString(),
                  amountToPay: amountToPay.toString(),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubHeadlines({
    required BuildContext context,
    required String subHeadline,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w),
      child: MyTextPoppines(
        text: subHeadline,
        fontWeight: FontWeight.w600,
        fontSize: context.screenHeight / 48.8,
      ),
    );
  }
}
