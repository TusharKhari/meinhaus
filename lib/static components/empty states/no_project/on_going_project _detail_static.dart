import 'package:flutter/material.dart';
import 'package:new_user_side/features/estimate/widget/download_pdf_card_widget.dart';
 
import '../../../resources/common/my_app_bar.dart';
import '../../../resources/common/my_text.dart';
import '../../../resources/font_size/font_size.dart';
import '../../../utils/constants/app_colors.dart';
import 'buttons_panel_static.dart';
import 'ongoing_bill_card_Static.dart';
import 'pro_profile_static.dart';

class OnGoingProjectDetailsStatic extends StatefulWidget {
  const OnGoingProjectDetailsStatic({super.key});

  @override
  State<OnGoingProjectDetailsStatic> createState() =>
      _OnGoingProjectDetailsStaticState();
}

class _OnGoingProjectDetailsStaticState
    extends State<OnGoingProjectDetailsStatic> {

      @override
      void initState() {
        super.initState();
        
      }
      showInfo(){
       
      }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      appBar: MyAppBar(text: "Sample Ongoing Projects"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DownloadPdfCard(
              workName: "Kitchen Repairing",
            ),
            SizedBox(height: height / 120),
            Divider(thickness: height * 0.003, height: 0.0),
            SizedBox(height: height / 60),

            //

            Row(
              children: [
                SizedBox(width: width / 12),
                MyTextPoppines(
                  text: "Estimate  No :",
                  fontSize: size.height * FontSize.sixteen,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(width: width / 20),
                MyTextPoppines(
                  text: "OD-18CM17",
                  fontSize: size.height * FontSize.sixteen,
                  fontWeight: FontWeight.w400,
                  color: AppColors.yellow,
                ),
              ],
            ),
            Divider(thickness: height * 0.003),
            SizedBox(height: height / 90),
            OngoingProjectBillCardStatic(),
            SizedBox(height: height / 90),
            Divider(thickness: height * 0.003),
            SizedBox(height: height / 90),
            // DESCRIPTION

            Padding(
              padding: EdgeInsets.only(left: 0, bottom: height / 90),
              child: MyTextPoppines(
                text: "Description :",
                fontWeight: FontWeight.w600,
                fontSize: size.height * FontSize.sixteen,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: width / 20,
                bottom: height / 90,
                right: width / 15,
              ),
              child: MyTextPoppines(
                text: 'This area usually provides details about the project.',
                fontSize: size.height * FontSize.fourteen,
                fontWeight: FontWeight.w500,
                height: 1.6,
                color: AppColors.black.withOpacity(0.6),
                maxLines: 100,
              ),
            ),
            // ============
            Divider(thickness: height * 0.003),
            OngoingJobsButtonsPanelStatic(),
            Divider(thickness: height * 0.003),
            SizedBox(height: height / 40),
            ProProfileWidgetStatic(),
          ],
        ),
      ),
    );
  }
}
