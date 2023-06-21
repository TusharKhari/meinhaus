import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:new_user_side/provider/notifiers/estimate_notifier.dart';
import 'package:new_user_side/res/common/my_app_bar.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/sizer.dart';
import 'package:provider/provider.dart';

import '../widget/ewopph_card.dart';

class ProjectHistory extends StatefulWidget {
  static const String routeName = '/projectHistory';

  const ProjectHistory({
    Key? key,
  }) : super(key: key);

  @override
  State<ProjectHistory> createState() => _ProjectHistoryState();
}

class _ProjectHistoryState extends State<ProjectHistory> {
  @override
  void initState() {
    super.initState();
    getProjectsHistory();
  }

  Future<void> getProjectsHistory() async {
    final notifer = context.read<EstimateNotifier>();
    await notifer.getProjectsHistory();
  }

  @override
  Widget build(BuildContext context) {
    final notifer = context.watch<EstimateNotifier>();
    final project = notifer.projectsHistory.projects;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: MyAppBar(text: "Project History"),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          children: [
            3.vspacing(context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: MyTextPoppines(
                text:
                    "We have record of your last projects .Tap to view details.",
                fontSize: height / MyFontSize.font16,
                fontWeight: FontWeight.w500,
              ),
            ),
            4.vspacing(context),
            project != null
                ? Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: project.length,
                      itemBuilder: (context, index) {
                        return AllOPPPHCard(
                          index: index,
                          projects: project,
                        );
                      },
                    ),
                  )
                : Center(
                    child: LoadingAnimationWidget.inkDrop(
                        color: AppColors.buttonBlue,
                        size: context.screenWidth / 40),
                  ),
          ],
        ),
      ),
    );
  }
}
