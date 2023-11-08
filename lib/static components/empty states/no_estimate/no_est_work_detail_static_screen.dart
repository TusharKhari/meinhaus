


import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:new_user_side/static%20components/empty%20states/widgets/static_project_billing_card_widget.dart';
// import 'package:new_user_side/static%20components/empty%20states/widgets/static_project_estimate_card.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../features/estimate/widget/download_pdf_card_widget.dart';
import '../../../resources/common/buttons/my_bottom_bar_button.dart';
import '../../../resources/common/my_app_bar.dart';
import '../../../resources/common/my_text.dart';
import '../../../utils/constants/app_colors.dart';
import 'static_project_billing_card_widget.dart';
import 'static_project_estimate_card.dart';
import 'checkout_screen_static.dart';
import '../screens/project_estimate_static_data.dart';


class NoEstWorkDetailStaticScreen extends StatelessWidget {
  static const String routeName = '/estimatedWorkDetailStaticScreen';
  const NoEstWorkDetailStaticScreen({super.key});

  @override
  Widget build(BuildContext context) {
     final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: MyAppBar(text: "Sample Estimated Work"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Download PDF
          DownloadPdfCard(workName:  "Project Name"),
          // DownloadPdfCard(workName: projectDetails.projectName ?? ""),
          SizedBox(height: height / 120),
          Divider(thickness: 1.8, height: 0.0),
          SizedBox(height: height / 90),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ESTIMATE NUMBER
                  Row(
                    children: [
                      SizedBox(width: width / 16),
                      MyTextPoppines(
                        text: "Estimate  No :",
                     fontSize:16.sp,
                        // fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(width: width / 16),
                      MyTextPoppines(
                    //   text: projectDetails.estimateId ?? "",
                       text: "Estimate id",
                       fontSize:16.sp,
                        // fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.yellow,
                      ),
                    ],
                  ),
                  Divider(thickness: 1.8),
                  SizedBox(height: height / 90),
                  // BILL DETAILS 
                 _EstimatedDetailsColumn(), 
                  SizedBox(height: height / 40),
                  Divider(thickness: 1.8),
                  SizedBox(height: height / 40),
                  // SERVICES
                  _buildSubHeadlines(
                    context: context,
                    subHeadline: "Project Estimate :",
                  ),
               //  EstimateServiceCardWidget(),
               
               ListView.builder(
               shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(),
                itemCount: projectEstimateStaticData.length,
                itemBuilder: (context, index) {
                 return StaticProjectEstimateCard(
                  index: index,
                 );
               },), 
             //  StaticProjectEstimateCard(),
                  SizedBox(height: height / 90),
                   // PROJECT IMAGES
                  Visibility(
                    visible: true,
                    child: _buildSubHeadlines(
                      context: context,
                      subHeadline: "Uploaded Photos :",
                    ),
                  ),
                  // =======
                  // Visibility(
                  //   visible: true,
                  //   child: Column(
                  //     children: [
                  //       SizedBox(height: height / 40),
                  //      // EstimateCarouselImg(index: 0),
                  //       SizedBox(height: height / 30),
                  //     ],
                  //   ),
                  // ),
                  // UPLOAD MORE IMAGES OPTION
                // ShowImgUploadOption(bookingId: ''),
                5.vspacing(context), 
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20,),
                  child: DottedBorder(
                    dashPattern: const [4, 8],
                    strokeCap: StrokeCap.round,
                    borderType: BorderType.RRect,
                    radius: Radius.circular(6),
                    padding: EdgeInsets.symmetric(
                        horizontal: width / 50, vertical: height / 30),
                    color: AppColors.textBlue,
                    child: InkWell(
                      onTap: () {},
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.file_upload_outlined,
                              size: width / 12,
                              color: AppColors.textBlue,
                            ),
                            2.vspacing(context),
                            MyTextPoppines(
                              text: "Upload Images",
                              fontSize: width / 32,
                              color: AppColors.textBlue,
                              fontWeight: FontWeight.w600,
                            ), 
                             5.vspacing(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              //======
                  SizedBox(height: height / 40),
                  _buildSubHeadlines(
                    context: context,
                    subHeadline: "Project Billing :",
                  ),
                  // PROJECT BILL CARD
                 StaticProjectBillingCard(), 
                ],
              ),
            ),
          ),
        ],
      ),
      // BOOK PROJECT BUTTON
      bottomNavigationBar: MyBottomNavWidget(
        hPadding: width / 7.6,
        text: "Book Project",
        onTap: () {
          Navigator.of(context).pushScreen(
            CheckOutScreenStatic(
              ProjectName:   "Sample Project Name",
              bookingId: "11",
              //amountToPay: amountToPay ?? "",
              // projectDetails
              // amountToPay: projectDetails.projectBilling!.hstAmountToPay != null ?  projectDetails.projectBilling!.hstAmountToPay.toString() : "NA" ,
              amountToPay: "\$100",
            ),
          );
         // showSnakeBarr(context, "No Projects available", SnackBarState.Warning);
        },
      ),
    );
  }
  Widget _buildSubHeadlines({
    required BuildContext context,
    required String subHeadline,
  }) {
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.only(left: width / 22),
      child: MyTextPoppines(
        text: subHeadline,
        fontWeight: FontWeight.w600,
       fontSize:20.sp,
        // fontSize: width / 25,
      ),
    );
  }
}

class _EstimatedDetailsColumn extends StatelessWidget {
  const _EstimatedDetailsColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         _EstimatedDetailsRow(
          prefixText: "Estimate Date :",
          suffixText: "01/01/23",
        ),
        15.vs,
        _EstimatedDetailsRow(
          prefixText: "Deposited Amount :",
         //suffixText: "\$${projectDetails.projectBilling!.depositAmount}",
        suffixText:  "\$100",
        ),
        15.vs,
        _EstimatedDetailsRow(
          prefixText: "Bill To :",
          suffixText: "44 E. West Street Ashland, OH 44805.",
        ),
        15.vs,
        _EstimatedDetailsRow(
          prefixText: "Email :",
          suffixText: "emailsample@gmail.com",
        ),
        15.vs,
        _EstimatedDetailsRow(
          prefixText: "Contact No :",
          suffixText: "+1 (519)641-1743",
        ),

      ],
    );
  }
}



class _EstimatedDetailsRow extends StatelessWidget {
  final String prefixText;
  final String suffixText;
  const _EstimatedDetailsRow({
    Key? key,
    required this.prefixText,
    required this.suffixText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        30.hs,
        MyTextPoppines(
          text: prefixText,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          height: 1.5,
        ),
        10.hs,
        Expanded(
          child: MyTextPoppines(
            text: suffixText,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            maxLines: 10,
            height: 1.5,
          ),
        ),
        70.hs,
      ],
    );
  }
}

