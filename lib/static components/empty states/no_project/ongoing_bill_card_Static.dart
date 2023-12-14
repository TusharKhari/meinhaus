import 'package:flutter/material.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../resources/font_size/font_size.dart';

class OngoingProjectBillCardStatic extends StatelessWidget {
  const OngoingProjectBillCardStatic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProjectDetailsRow(
          prefixText: "Project Started On :",
          suffixText: "23-11-01",
        ),
        15.vs,
        ProjectDetailsRow(
          prefixText: "Project Cost :",
          suffixText: "\$2480",
        ),
        15.vs,
        ProjectDetailsRow(
          prefixText: "Address Details :",
          suffixText: "251 Queen Street South, Mississauga, Ontario. L5M1Y2",
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
