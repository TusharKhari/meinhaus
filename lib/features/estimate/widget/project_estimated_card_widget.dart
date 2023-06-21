// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/data/network/network_api_servcies.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/constants/constant.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../provider/notifiers/estimate_notifier.dart';

class ProjectEstimatedCardWidget extends StatelessWidget {
  final int index;
  const ProjectEstimatedCardWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifier = context.read<EstimateNotifier>().estimated;
    final projectEstimate = notifier.estimatedWorks![index].projectEstimate;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: projectEstimate!.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index2) {
        return _BuildServiceCard(index: index, index2: index2);
      },
    );
  }
}

class _BuildServiceCard extends StatefulWidget {
  final int index;
  final int index2;
  const _BuildServiceCard({
    Key? key,
    required this.index,
    required this.index2,
  }) : super(key: key);

  @override
  State<_BuildServiceCard> createState() => __BuildServiceCardState();
}

class __BuildServiceCardState extends State<_BuildServiceCard> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final getEstProvider = context.watch<EstimateNotifier>().estimated;
    final projectEstimate = getEstProvider.estimatedWorks![widget.index];
    final service = projectEstimate.projectEstimate![widget.index2];
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
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
                fontSize: height / 55.78,
              ),
              20.hs,
              MyTextPoppines(
                text: service.projectArea.toString(),
                fontSize: height / 65,
              ),
            ],
          ),
          10.vs,
          MyTextPoppines(
            text: "Description ",
            fontWeight: FontWeight.w600,
            fontSize: height / 55.78,
          ),
          10.vs,
          Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: MyTextPoppines(
              text: service.projectDescription.toString(),
              fontSize: height / 65,
              maxLines: 100,
              height: 1.4,
              color: AppColors.black.withOpacity(0.5),
            ),
          ),
          15.vs,
          Row(
            children: [
              MyTextPoppines(
                text: "Desposit Amount :",
                fontSize: height / 55.75,
                fontWeight: FontWeight.w600,
              ),
              20.hs,
              MyTextPoppines(
                text: "\$${service.depositAmount}",
                fontSize: height / 65,
                fontWeight: FontWeight.w600,
                color: AppColors.yellow,
              ),
            ],
          ),
          15.vs,
          Row(
            children: [
              MyTextPoppines(
                text: "Project Cost :",
                fontSize: height / 55.75,
                fontWeight: FontWeight.w600,
              ),
              20.hs,
              MyTextPoppines(
                text: "\$${service.projectCost}",
                fontSize: height / 65,
                fontWeight: FontWeight.w600,
                color: AppColors.yellow,
              ),
            ],
          ),
          20.vs,
          _BuildButton(index: widget.index, index2: widget.index2)
        ],
      ),
    );
  }
}

class _BuildButton extends StatefulWidget {
  final int index;
  final int index2;
  const _BuildButton({
    Key? key,
    required this.index,
    required this.index2,
  }) : super(key: key);

  @override
  State<_BuildButton> createState() => __BuildButtonState();
}

class __BuildButtonState extends State<_BuildButton> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final getEstProvider = context.watch<EstimateNotifier>().estimated;
    final projectEstimate = getEstProvider.estimatedWorks![widget.index];
    final service = projectEstimate.projectEstimate![widget.index2];
    int status = service.status!;
    int projectId = service.projectId!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyTextPoppines(
          text: "Action :",
          fontSize: height / 55.78,
          fontWeight: FontWeight.w600,
        ),
        20.hs,
        InkWell(
          onTap: () => _handleTapAction(status, projectId),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              color: _getStatusColor(status),
              boxShadow: buttonShadow,
            ),
            child: MyTextPoppines(
              text: _getStatusText(status),
              fontWeight: FontWeight.w600,
              color: AppColors.white,
              fontSize: context.screenHeight / 65,
            ),
          ),
        )
      ],
    );
  }

  Color _getStatusColor(int status) {
    switch (status) {
      case 0:
        return const Color(0xFF00FF00); // Green color for status 1
      case 1:
        return const Color(0xFFFE2828); // Red color for status 0
      case 2:
        return const Color(0xFFFFFF00); // Yellow color for status 2
      default:
        return Colors.grey; // Default color for unknown status
    }
  }

  String _getStatusText(int status) {
    switch (status) {
      case 0:
        return "Add Service"; // Text "Remove" for status 0
      case 1:
        return "Remove Service"; // Text "Add" for status 1
      case 2:
        return "Paid"; // Text "Paid" for status 2
      default:
        return "Unknown"; // Default text for unknown status
    }
  }

  _handleTapAction(int status, int id) {
    switch (status) {
      case 0:
        _toggleService(id);
        break;
      case 1:
        _toggleService(id);
        break;
      case 2:
        () {};
        break;
      default:
        break;
    }
  }

  Future _toggleService(id) async {
    final notifier = context.read<EstimateNotifier>();
    MapSS body = {"project_id": id.toString()};
    await notifier.toggleService(context: context, body: body);
  }
}
