import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../provider/notifiers/estimate_notifier.dart';
import '../../../utils/extensions/full_screen_image_view.dart';

class OngoingProjectPhotoCardWidget extends StatelessWidget {
  const OngoingProjectPhotoCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final EdgeInsets paddingH15 = EdgeInsets.symmetric(horizontal: 15.w);
    const String imgPath = "assets/images/fixing/fixing_";
    final notifier = context.watch<EstimateNotifier>();
    final services = notifier.projectDetails.services!;
    return Padding(
      padding: paddingH15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTextPoppines(
            text: "Project Photos :",
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
          20.vs,
          Container(
            padding: paddingH15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(30, 0, 0, 0),
                  blurRadius: 10.r,
                  spreadRadius: 2.r,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.vs,
                MyTextPoppines(
                  text: "Uploaded Photos :",
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
                10.vs,
                MasonryGridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: services.projectImages!.length,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: InkWell(
                      onTap: () {
                        final imgs = services.projectImages;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullScreenImageView(
                              images: imgs!,
                              currentIndex: index,
                            ),
                          ),
                        );
                      },
                      child: Image.network(services.projectImages![index]),
                    ),
                  ),
                ),
                6.vspacing(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
