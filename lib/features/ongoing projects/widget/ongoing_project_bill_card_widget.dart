import 'package:flutter/material.dart';
 import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../provider/notifiers/estimate_notifier.dart';
import '../../../resources/font_size/font_size.dart';

class OngoingProjectBillCardWidget extends StatelessWidget {
  const OngoingProjectBillCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<EstimateNotifier>();
    final services = notifier.projectDetails.services!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProjectDetailsRow(
          prefixText: "Project Started On :",
          suffixText: services.projectStartDate.toString(),
        ),
        15.vs,
        ProjectDetailsRow(
          prefixText: "Project Cost :",
          suffixText: "\$${services.projectCost}",
        ),
        15.vs,
        ProjectDetailsRow(
          prefixText: "Address Details :",
          suffixText: services.address.toString(),
        ),
      ],
    );
  }
}

class ProjectDetailsRow extends StatelessWidget {
  final String prefixText;
  final String suffixText;
  const ProjectDetailsRow({
    Key? key,
    required this.prefixText,
    required this.suffixText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.hs,
        MyTextPoppines(
          text: prefixText,
          fontSize: size.height * FontSize.sixteen,
          fontWeight: FontWeight.w500,
          height: 1.5,
        ),
        10.hs,
        Expanded(
          // width: 260.w,
          child: MyTextPoppines(
            text: suffixText,
            fontSize: size.height * FontSize.sixteen,
            fontWeight: FontWeight.w400,
            maxLines: 3,
            height: 1.5,
          ),
        ),
        5.hs,
      ],
    );
  }
}
