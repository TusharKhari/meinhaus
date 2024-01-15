// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../resources/common/my_text.dart';
import '../../../resources/font_size/font_size.dart';

class CheckOutSummaryCardWidget extends StatefulWidget {
  final String totalAmount;
  final String projectName;
  CheckOutSummaryCardWidget({
    Key? key,
    required this.totalAmount,
    required this.projectName,
  }) : super(key: key);

  @override
  State<CheckOutSummaryCardWidget> createState() =>
      _CheckOutSummaryCardWidgetState();
}

class _CheckOutSummaryCardWidgetState extends State<CheckOutSummaryCardWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTextPoppines(
          text: "Summary",
          fontSize: size.height * FontSize.sixteen,
          fontWeight: FontWeight.w600,
        ),
        15.vs,
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(20, 0, 0, 0),
                offset: const Offset(0, 0),
                blurRadius: 10.r,
                spreadRadius: 2.r,
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTextPoppines(
                text: "Project details",
                fontSize: size.height * FontSize.sixteen,
                fontWeight: FontWeight.w600,
              ),
              20.vs,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * 0.4,
                          // margin: EdgeInsets.symmetric(horizontal: 3),
                          child: MyTextPoppines(
                            // text: estimate.estimatedWorks![0].projectName!,
                            text: "${widget.projectName}",
                            //  text: "Bathroom Renewall",
                            fontSize: size.height * FontSize.fourteen,
                            fontWeight: FontWeight.w600,
                            maxLines: 9,
                          ),
                        ),
                        MyTextPoppines(
                          text: "\$${widget.totalAmount}",
                          fontSize: size.height * FontSize.fourteen,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    // 15.vs,
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     MyTextPoppines(
                    //       text: "Other charges",
                    //       fontSize: size.height * FontSize.fourteen,
                    //     ),
                    //     MyTextPoppines(
                    //       text: "0",
                    //       fontSize: size.height * FontSize.fourteen,
                    //     ),
                    //   ],
                    // ),
                    15.vs,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyTextPoppines(
                          text: "13% HST",
                          fontSize: size.height * FontSize.fourteen,
                        ),
                        MyTextPoppines(
                          text:
                              "${(double.parse(widget.totalAmount) * 0.13).toStringAsFixed(2)}",
                          fontSize: size.height * FontSize.fourteen,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1.2),
              10.vs,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyTextPoppines(
                    text: "To Pay",
                    fontSize: size.height * FontSize.fourteen,
                    fontWeight: FontWeight.w600,
                  ),
                  MyTextPoppines(
                    text:
                        "\$${(double.parse(widget.totalAmount) + (double.parse(widget.totalAmount) * 0.13)).toStringAsFixed(2)}",
                    fontSize: size.height * FontSize.fourteen,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
