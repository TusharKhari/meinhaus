// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/data/models/ongoing_project_model.dart';
import 'package:new_user_side/data/network/network_api_servcies.dart';
import 'package:new_user_side/features/chat%20with%20pro/screens/chat_with_pro_chat_list_screen.dart';
import 'package:new_user_side/features/estimate/screens/estimate_generation_screen.dart';
import 'package:new_user_side/features/our%20services/screens/our_service_card.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../provider/notifiers/chat_with_pro_notifier.dart';
import '../../../provider/notifiers/estimate_notifier.dart';
import '../../../provider/notifiers/our_services_notifier.dart';
import '../../../static componets/dialogs/home_dialog.dart';
import '../../../static componets/drawer/my_drawer_widget.dart';
import '../../../utils/sizer.dart';
import '../../notification/screens/notification_scree.dart';
import '../../ongoing projects/screens/all_ongoing_projects_screen.dart';
import '../widget/estimated_work_card_widget.dart';
import '../widget/home_offer_banner_widget.dart';
import '../widget/on_going_project_card.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/Home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isExpanded = true;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      showDialog(
        context: context,
        builder: (context) {
          return const ShowDialogBox();
        },
      );
    });
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _isExpanded = true;
      });
      Timer(const Duration(seconds: 4), () {
        setState(() {
          _isExpanded = false;
        });
      });
    });
    getEstimate();
    getOngoingProjects();
    getOurServices();
  }

  Future<void> getEstimate() async {
    final notifer = context.read<EstimateNotifier>();
    await notifer.getEstimateWork();
  }

  Future<void> getOngoingProjects() async {
    final notifer = context.read<EstimateNotifier>();
    await notifer.getOngoingProjects();
  }

  Future<void> getOurServices() async {
    final notifer = context.read<OurServicesNotifier>();
    await notifer.getOurServices();
  }

  @override
  Widget build(BuildContext context) {
    final height = context.screenHeight;
    final estimateNotifier = context.watch<EstimateNotifier>();
    final ourServicesNotifier = context.watch<OurServicesNotifier>();
    final ourservices = ourServicesNotifier.services.services;
    final estimateWork = estimateNotifier.estimated.estimatedWorks;
    final ongoingProjects = estimateNotifier.ongoingProjects.projects;
    final project = ongoingProjects ?? OngoingProjectsModel().projects;

    Widget customDivider = Divider(
      thickness: 1.0,
      color: AppColors.grey.withOpacity(0.2),
      height: 5.h,
    );

    return Scaffold(
      appBar: PreferredSize(
        child: HomePageAppBar(),
        preferredSize: Size.fromHeight(height / 16),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customDivider,
          10.vs,
          InkWell(
            onTap: () {},
            child: const HomeOfferBanner(),
          ),
          10.vs,
          customDivider,
          10.vs,
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                color: AppColors.grey.withOpacity(0.05),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.vs,
                    // Estimated Works
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyTextPoppines(
                          text: "Estimated Work",
                          fontWeight: FontWeight.w600,
                          fontSize: height / MyFontSize.font18,
                        ),
                        15.vs,
                        estimateWork != null
                            ? estimateWork.length != 0
                                ? SizedBox(
                                    height: 265.h,
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: estimateWork.length,
                                      itemBuilder: (context, index) {
                                        return EstimatedWorkCard(index: index);
                                      },
                                    ),
                                  )
                                : Container(
                                    height: height / 12,
                                    width: context.screenWidth / 2.4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: AppColors.white,
                                      border: Border.all(),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 10,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          EstimateGenerationScreen.routeName,
                                          arguments: true,
                                        );
                                      },
                                      child: Icon(Icons.add),
                                    ),
                                  )
                            //: MyTextPoppines(text: "Shimmer effect here"),
                            : _buildShimmerEffect(),
                      ],
                    ),
                    30.vs,
                    // Ongoing Projects
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyTextPoppines(
                              text: "Ongoing Projects",
                              fontWeight: FontWeight.w600,
                              fontSize: height / MyFontSize.font18,
                            ),
                            InkWell(
                              onTap: () => context
                                  .pushNamedRoute(AllOngoingJobs.routeName),
                              child: MyTextPoppines(
                                text: "View All",
                                fontWeight: FontWeight.w500,
                                fontSize: height / MyFontSize.font14,
                              ),
                            ),
                          ],
                        ),
                        15.vs,
                        ongoingProjects != null
                            ? ongoingProjects.length != 0
                                ? SizedBox(
                                    height: height / 2.90,
                                    child: ListView.builder(
                                      shrinkWrap: false,
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: project!.length,
                                      itemBuilder: (context, index) {
                                        final bool isMultipleProjects =
                                            ongoingProjects[index]
                                                    .services!
                                                    .length >
                                                1;
                                        return OngoingWorkCard(
                                          isMultiProjects: isMultipleProjects,
                                          index: index,
                                        );
                                      },
                                    ),
                                  )
                                : MyTextPoppines(text: "No Ongoing Projects")
                            // : MyTextPoppines(text: "Shimmer effect here"),
                            : _buildShimmerEffect(),
                      ],
                    ),
                    20.vs,
                    // Our services
                    ourservices != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyTextPoppines(
                                text: "Our Services",
                                fontWeight: FontWeight.w600,
                                fontSize: height / MyFontSize.font18,
                              ),
                              SizedBox(
                                height: height / 2.30,
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: ourservices.length,
                                  itemBuilder: (context, index) {
                                    return OurServicesCard(
                                      index: index,
                                    );
                                  },
                                ),
                              ),
                              20.vs,
                            ],
                          )
                        : _buildShimmerEffect(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: _isExpanded
              ? height > 800
                  ? 190.w
                  : 160.w
              : 50.w,
          height: 45.h,
          decoration: BoxDecoration(
            borderRadius: _isExpanded
                ? BorderRadius.circular(30.r)
                : BorderRadius.circular(14.r),
            color: AppColors.black,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (_isExpanded)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w, left: 20.w),
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(
                        context,
                        EstimateGenerationScreen.routeName,
                        arguments: true,
                      ),
                      child: MyTextPoppines(
                        text: "Create New Est",
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
              Icon(
                Icons.add_circle_outline,
                color: AppColors.white,
                size: 25.sp,
              ),
              if (_isExpanded) 10.hs,
            ],
          ),
        ),
      ),
      drawer: const MyDrawer(),
    );
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              width: 190.w,
              height: 230.h,
              margin: EdgeInsets.only(right: 10.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.r),
                color: AppColors.white,
              ),
            ),
            Container(
              width: 190.w,
              height: 230.h,
              margin: EdgeInsets.only(right: 10.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.r),
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // AllConversation
    Future allConversation() async {
      final notifier = context.read<ChatWithProNotifier>();
      await notifier.allConversation(context);
      context.pushNamedRoute(ChatWIthProChatListScreen.routeName);
    }

    Future loadMessages() async {
      final notifier = context.read<ChatWithProNotifier>();
      MapSS body = {"to_user_id": "4"};
      await notifier.loadMessages(context: context, body: body);
    }

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leadingWidth: 100.w,
      leading: Row(
        children: [
          15.hs,
          Builder(
            builder: (context) => InkWell(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Image.asset("assets/icons/menu.png"),
            ),
          ),
          15.hs,
          Image.asset("assets/logo/home.png", scale: 1.8),
        ],
      ),
      actions: [
        20.hs,
        InkWell(
          onTap: () => loadMessages(),
          child: Icon(
            CupertinoIcons.text_bubble,
            color: AppColors.black.withOpacity(0.8),
            size: 28.sp,
          ),
        ),
        20.hs,
        InkWell(
          onTap: () => context.pushNamedRoute(NotificationScreen.routeName),
          child: Icon(
            CupertinoIcons.bell,
            color: AppColors.black.withOpacity(0.8),
            size: 28.sp,
          ),
        ),
        10.hs,
      ],
    );
  }
}
