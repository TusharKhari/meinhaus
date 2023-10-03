


import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../utils/constants/app_colors.dart';
import 'no_est_static_screen.dart';

class NoEstShowCaseView extends StatefulWidget {
  const NoEstShowCaseView({super.key});

  @override
  State<NoEstShowCaseView> createState() => _NoEstShowCaseViewState();
}

class _NoEstShowCaseViewState extends State<NoEstShowCaseView> {
  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();

  @override
  void initState() {
    super.initState();
     (WidgetsBinding.instance).addPostFrameCallback(
      (_) => ShowCaseWidget.of(context)
          .startShowCase([_one, _two,]),
    );
  }
  

  @override
  Widget build(BuildContext context) {
   // return NoEstStaticScreen();
   final width = MediaQuery.of(context).size.width;
   
   return Container(
      width: width / 2,
      margin: EdgeInsets.only(right: width / 35),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width / 28),
        color: AppColors.white,
      )
   );
  }
}