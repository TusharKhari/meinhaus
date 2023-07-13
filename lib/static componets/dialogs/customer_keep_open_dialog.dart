import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:new_user_side/provider/notifiers/support_notifier.dart';
import 'package:new_user_side/res/common/buttons/my_buttons.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/extensions/validator.dart';
import 'package:provider/provider.dart';

import '../../features/auth/screens/user_details.dart';

class CustomerSupportKeepOpenDialog extends StatelessWidget {
  const CustomerSupportKeepOpenDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // Key to validate form
    final _keepOpenKey = GlobalKey<FormState>();
    final notifier = context.watch<SupportNotifier>();
    final h = context.screenHeight;
    final w = context.screenWidth;

    // keep open support query
    Future _keepOpenHandler() async {
      final notifier = context.read<SupportNotifier>();
      if (_keepOpenKey.currentState!.validate()) {
        await notifier.keepOpen(context);
      }
    }

    return Dialog(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: w / 30, vertical: h / 85),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Form(
                key: _keepOpenKey,
                child: MyTextField(
                  text: "Enter the reason for cancellation",
                  headingFontWeight: FontWeight.w600,
                  maxLines: 10,
                  hintText: "Write down the reason here.",
                  isHs20: false,
                  controller: notifier.messageController,
                  validator: Validator().nullValidator,
                ),
              ),
              SizedBox(height: h / 85),
              notifier.loading
                  ? LoadingAnimationWidget.inkDrop(
                      color: AppColors.buttonBlue, size: w / 30)
                  : MyBlueButton(
                      hPadding: w / 20,
                      vPadding: h / 70,
                      text: "Submit it",
                      fontSize: w / 30,
                      onTap: () => _keepOpenHandler(),
                    ),
              SizedBox(height: h / 85),
            ],
          ),
        ),
      ),
    );
  }
}
