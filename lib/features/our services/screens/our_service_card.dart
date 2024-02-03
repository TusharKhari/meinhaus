// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/resources/font_size/font_size.dart';
import 'package:provider/provider.dart';

import 'package:new_user_side/features/our%20services/screens/our_services_screen.dart';
import 'package:new_user_side/provider/notifiers/our_services_notifier.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../resources/common/buttons/my_buttons.dart';

class OurServicesCard extends StatelessWidget {
  final int index;
  final bool? isNoLogin;
  const OurServicesCard({Key? key, required this.index, this.isNoLogin = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final notifier = context.read<OurServicesNotifier>();
    final services = notifier.services.services![index];
    return Container(
      width: size.width / 1.4,
      margin: EdgeInsets.only(top: size.height / 80, right: size.width / 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          1.vspacing(context),
          Container(
            width: size.width / 1.45,
            height: size.height * 0.19,
            // height: 130.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              image: DecorationImage(
                image: NetworkImage(services.serviceDescImage!),
                fit: BoxFit.cover,
              ),
              //  image: DecorationImage(
              //   image: NetworkImage(services.serviceDescImage.toString()),
              //   fit: BoxFit.cover,
              // ),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(
                    left: size.width / 35, bottom: size.height / 120),
                child: MyTextPoppines(
                  text: services.name.toString(),
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                  fontSize: 18.sp,
                ),
              ),
            ),
          ),
          1.vspacing(context),
          Divider(thickness: 1.0),
          Padding(
            // padding: EdgeInsets.symmetric( ),
            padding: EdgeInsets.symmetric(horizontal: size.width / 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextPoppines(
                  text: services.description.toString(),
                  maxLines: 2,
                  fontSize: size.height * FontSize.fourteen,
                  // fontSize: size.height * FontSize.fourteen,
                  // fontSize: width / 38,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                // 4.vspacing(context),
                MyTextPoppines(
                  text: "50 + Top Rated Pro",
                  maxLines: 2,
                  fontSize: size.height * FontSize.twelve,
                  //  fontSize: size.height * FontSize.twelve,
                  fontWeight: FontWeight.w600,
                  color: AppColors.golden,
                ),
                // 2.vspacing(context),
                SizedBox(
                  height: size.height * 0.01,
                ),
                MyTextPoppines(
                  text: "10 + Years of experience",
                  maxLines: 2,
                  fontSize: size.height * FontSize.twelve,
                  // fontSize: width / 35,
                  fontWeight: FontWeight.w600,
                  color: AppColors.golden,
                ),
              ],
            ),
          ),
          //  6.vspacing(context),
          SizedBox(
            height: size.height * 0.01,
          ),
          Align(
            alignment: Alignment.center,
            child: MyBlueButton(
              hPadding: 10.w,
              vPadding: size.height / 120,
              text: "View Service",
              fontSize: size.height * FontSize.fourteen,
              fontWeight: FontWeight.w600,
              onTap: () {
                // Navigator.pushNamed(
                //   context,
                //   OurServiceScreen.routeName,
                //   arguments: index,
                // );
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OurServiceScreen(
                        index: index,
                        isNoLogin: isNoLogin,
                      ),
                    ));
              },
            ),
          )
        ],
      ),
    );
  }
}
