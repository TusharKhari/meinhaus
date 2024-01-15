import 'package:flutter/material.dart';
import 'package:new_user_side/static%20components/dialogs/static_screens_dialog.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import '../../../resources/common/my_text.dart';
import '../../../resources/font_size/font_size.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/constant.dart';
import '../screens/project_estimate_static_data.dart';

class StaticProjectEstimateCard extends StatefulWidget {
  int index;
  StaticProjectEstimateCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<StaticProjectEstimateCard> createState() =>
      _StaticProjectEstimateCardState();
}

class _StaticProjectEstimateCardState extends State<StaticProjectEstimateCard> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final size = MediaQuery.of(context).size;

    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: width / 14, vertical: height / 40),
      padding:
          EdgeInsets.symmetric(horizontal: width / 22, vertical: height / 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width / 22),
        color: AppColors.white,
        boxShadow: boxShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MyTextPoppines(
                text: "Project Area :",
                fontWeight: FontWeight.w600,
                fontSize: size.height * FontSize.sixteen,
              ),
              SizedBox(width: width / 22),
              Flexible(
                child: MyTextPoppines(
                  maxLines: 3,
                  // height: 10,
                  // text: "Project Area",
                  //v project_area
                  text: projectEstimateStaticData[widget.index]
                      ["project_area"]!,
                  fontSize: size.height * FontSize.sixteen,
                ),
              ),
            ],
          ),
          SizedBox(height: height / 80),
          MyTextPoppines(
            text: "Description ",
            fontWeight: FontWeight.w600,
            fontSize: size.height * FontSize.sixteen,
          ),
          SizedBox(height: height / 80),
          Padding(
            padding: EdgeInsets.only(left: width / 30),
            child: MyTextPoppines(
              // text:  "Description of project",
              // projectEstimateStaticData
              text: projectEstimateStaticData[widget.index]["description"]!,
              fontSize: size.height * FontSize.fourteen,
              maxLines: 100,
              height: 1.4,
              color: AppColors.black.withOpacity(0.5),
            ),
          ),
          SizedBox(height: height / 60),
          Row(
            children: [
              MyTextPoppines(
                text: "Project Cost :",
                fontSize: size.height * FontSize.sixteen,
                fontWeight: FontWeight.w600,
              ),
              20.hs,
              MyTextPoppines(
                // text: "\$00",
                text: "\$${projectEstimateStaticData[widget.index]["price"]!}",
                fontSize: size.height * FontSize.sixteen,
                fontWeight: FontWeight.w600,
                color: AppColors.yellow,
              ),
            ],
          ),
          SizedBox(height: height / 40),
          Visibility(
            visible: 2 > 1,
            child: _BuildButton(),
          )
        ],
      ),
    );
  }
}

class _BuildButton extends StatefulWidget {
  const _BuildButton({
    Key? key,
  }) : super(key: key);

  @override
  State<_BuildButton> createState() => __BuildButtonState();
}

class __BuildButtonState extends State<_BuildButton> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyTextPoppines(
          text: "Action :",
          fontSize: size.height * FontSize.sixteen,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(width: width / 22),
        //  notifier.toggleLoading
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return StaticScreensDialog(
                    subtitle:
                        "Services can be removed or added back to a project by clicking here.");
              },
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: width / 22),
            padding: EdgeInsets.symmetric(
              horizontal: width / 22,
              vertical: height / 120,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black,
              boxShadow: buttonShadow,
            ),
            child: MyTextPoppines(
              text: "Remove Service",
              fontWeight: FontWeight.w600,
              color: AppColors.white,
              fontSize: width / 32,
            ),
          ),
        )
      ],
    );
  }
}
