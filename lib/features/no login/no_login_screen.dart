import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../provider/notifiers/our_services_notifier.dart';
import '../../resources/common/my_text.dart';
import '../../static components/empty states/no_estimate/no_est_static_screen.dart';
import '../../static components/empty states/no_project/on_going_work_card_static.dart';
import '../../utils/constants/app_colors.dart';
import '../auth/screens/signin_screen.dart';
import '../estimate/screens/estimate_generation_screen.dart';
import '../home/widget/home_offer_banner_widget.dart';
import '../home/widget/our_services_home_screen_view.dart';

class NoLoginScreen extends StatefulWidget {
  const NoLoginScreen({super.key});

  @override
  State<NoLoginScreen> createState() => _NoLoginScreenState();
}

class _NoLoginScreenState extends State<NoLoginScreen> {
  bool _isExpanded = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animateEstimateButton();
    gerServices();
  }

  void gerServices() async {
    await context.read<OurServicesNotifier>().getOurServices();
  }

  void animateEstimateButton() {
    Timer(const Duration(seconds: 2), () {
      if (mounted) setState(() => _isExpanded = true);
      Timer(const Duration(seconds: 4), () {
        if (mounted) setState(() => _isExpanded = false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height / 16),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leadingWidth: width / 3,
            leading: Row(
              children: [
                SizedBox(width: width / 28),
                Builder(
                  builder: (context) => InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, SignInScreen.routeName),
                    // onTap: () => Scaffold.of(context).openDrawer(),
                    child: Image.asset(
                      "assets/icons/menu.png",
                      width: width / 20,
                      height: height / 30,
                    ),
                  ),
                ),
                SizedBox(width: width / 28),
                InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, SignInScreen.routeName),
                  child: Container(
                    /// padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(vertical: 0.01 * height),
                    child: Image.asset(
                      "assets/logo/image 7 (2).png",
                      // scale: 4,
                      // width: width / 9,
                      // height: height / 25,
                      // fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, SignInScreen.routeName),
                  icon: Icon(CupertinoIcons.text_bubble))
            ],
          ),
        ),

        //
        floatingActionButton: GestureDetector(
          onTap: () {
            if (mounted)
              setState(() {
                _isExpanded = !_isExpanded;
              });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: _isExpanded ? width / 2.35 : 50,
            height: height / 16,
            decoration: BoxDecoration(
              borderRadius: _isExpanded
                  ? BorderRadius.circular(width / 12)
                  : BorderRadius.circular(width / 3),
              color: AppColors.black,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (_isExpanded)
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.only(right: width / 40, left: width / 20),
                      child: InkWell(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return EstimateGenerationScreen(
                              isDemoEstimate: true,
                            );
                          },
                        )),
                        child: MyTextPoppines(
                          text: "Create New Quote",
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                          fontSize: width / 32,
                        ),
                      ),
                    ),
                  ),
                Icon(
                  Icons.add_circle_outline,
                  color: AppColors.white,
                  size: width / 16,
                ),
                if (_isExpanded) SizedBox(width: width / 40),
              ],
            ),
          ),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Divider(
          //   thickness: 1.0,
          //   color: AppColors.grey.withOpacity(0.2),
          // ),
          // SizedBox(height: height / 120),
          const HomeOfferBanner(isDemoEstimate: true),
          SizedBox(height: height / 120),
          Divider(
            thickness: 1.0,
            color: AppColors.grey.withOpacity(0.2),
          ),
          SizedBox(height: height / 120),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: AppColors.grey.withOpacity(0.05),
                padding: EdgeInsets.symmetric(horizontal: width / 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height / 80),
                    MyTextPoppines(
                      text: "Estimated Work",
                      fontWeight: FontWeight.w600,
                      // fontSize: height * FontSize.eighteen,
                      // fontSize: width / 23,
                    ),
                    NoEstStaticScreen(),
                    SizedBox(height: height / 70),
                    MyTextPoppines(
                      text: "Ongoing Projects",
                      fontWeight: FontWeight.w600,
                      // fontSize: height * FontSize.eighteen,
                      // fontSize: width / 23,
                    ),
                    // EstimateCardHomeScreenView(effect: _buildShimmerEffect),
                    SizedBox(height: height / 30),
                    OngoingWorkCardStatic(),
                    // OngoingCardHomeScreenView(effect: _buildShimmerEffect),
                    SizedBox(height: height / 30),
                    OurServicesCardHomeScreenView(
                        effect: _buildShimmerEffect, isNoLogin: true),
                  ],
                ),
              ),
            ),
          ),
        ]));
  }
}

Widget _buildShimmerEffect(BuildContext context) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            width: width / 2,
            height: height / 3.5,
            margin: EdgeInsets.only(right: width / 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(width / 30),
              color: AppColors.white,
            ),
          ),
          Container(
            width: width / 2,
            height: height / 3.5,
            margin: EdgeInsets.only(right: width / 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(width / 30),
              color: AppColors.white,
            ),
          ),
        ],
      ),
    ),
  );
}
