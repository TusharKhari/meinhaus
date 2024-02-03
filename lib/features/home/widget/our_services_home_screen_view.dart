import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/features/our%20services/screens/our_service_card.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:provider/provider.dart';

import '../../../provider/notifiers/our_services_notifier.dart';

class OurServicesCardHomeScreenView extends StatelessWidget {
  final Function(BuildContext context) effect;
  final bool? isNoLogin;
  const OurServicesCardHomeScreenView(
      {super.key, required this.effect, this.isNoLogin = false});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
 
    final ourServicesNotifier = context.watch<OurServicesNotifier>();

    final ourservices = ourServicesNotifier.services.services;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTextPoppines(
          text: "Our Services",
          fontWeight: FontWeight.w600,
          fontSize: 18.sp,
          // fontSize: width / 23,
        ),
        ourservices != null
            ? SizedBox(
                height: height * 0.4,
                // height: height / 2.30,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: ourservices.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                     return OurServicesCard(
                      isNoLogin: isNoLogin,
                      index: index,
                    );
                  },
                ),
              )
            : effect(context),
        SizedBox(height: height / 50),
      ],
    );
  }
}
