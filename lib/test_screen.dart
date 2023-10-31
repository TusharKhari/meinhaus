import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'features/additional work/widget/icon_button_with_text.dart';
import 'utils/constants/app_colors.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            IconButtonWithText(
              text: "Approve",
              textColor: AppColors.white,
              buttonColor: const Color(0xFF68E365),
              onTap: () => null,
              iconUrl: "assets/icons/approve_it.svg",
              isIcon: false,
            ),
            SvgPicture.asset("assets/icons/approved_verified.svg"),
          ],
        ),
      ),
    );
  }
}
