import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/constants/constant.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../resources/font_size/font_size.dart';

class OngoingProjectPhotoCardWidgetStatic extends StatelessWidget {
  final project;
  OngoingProjectPhotoCardWidgetStatic({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final size = MediaQuery.of(context).size;
    final EdgeInsets paddingH15 =
        EdgeInsets.symmetric(horizontal: size.height * FontSize.sixteen);

    return Padding(
      padding: paddingH15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTextPoppines(
            text: "Project Photos :",
            fontWeight: FontWeight.w600,
            fontSize: size.height * FontSize.sixteen,
          ),
          20.vs,
          Container(
            padding: paddingH15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: AppColors.white,
              boxShadow: boxShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.vs,
                GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 1,
                    // itemCount: project["projectPhotos"].length,
                    // itemCount: services.projectImages!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      if (project["service"] == "Demolition") {
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(width / 40),
                            child: Image.asset(
                              project["projectPhotos"][0],
                            ),
                          ),
                        );
                      }
                      if (project["service"] == "Plumbing") {
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(width / 40),
                            child: Image.asset(
                              project["projectPhotos"][1],
                            ),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(width / 40),
                            child: Image.asset(
                              project["projectPhotos"][2],
                            ),
                          ),
                        );
                      }
                    }),
                6.vspacing(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
