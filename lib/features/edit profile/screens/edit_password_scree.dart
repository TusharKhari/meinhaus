import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/features/auth/widgets/my_text_field.dart';
import 'package:new_user_side/features/edit%20profile/controller/provider/edit_profile_notifier.dart';
import 'package:new_user_side/features/edit%20profile/controller/services/edit_profile_services.dart';
import 'package:new_user_side/resources/common/my_app_bar.dart';
import 'package:new_user_side/resources/common/buttons/my_buttons.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/utils.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../../utils/extensions/validator.dart';
import '../../../resources/font_size/font_size.dart';

class EditPasswordScreen extends StatefulWidget {
  static const String routeName = '/editPassword';
  const EditPasswordScreen({super.key});

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  EditProfileServices passwordServices = EditProfileServices();
  final _editPasswordKey = GlobalKey<FormState>();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode oldPassNode = FocusNode();
  FocusNode newPassNode = FocusNode();
  FocusNode confrimPassNode = FocusNode();
  bool isWaiting = false;
  bool isSaveClicked = false;
  @override
  void dispose() {
    super.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    oldPassNode.dispose();
    newPassNode.dispose();
    confrimPassNode.dispose();
  }

  _editPasswordHandler() async {
    if (mounted)
      setState(() {
        isSaveClicked = true;
      });
    if (_editPasswordKey.currentState!.validate()) {
      isSaveClicked = false;
      final notifier = context.read<EditProfileNotifier>();
      final body = {
        "old_password": oldPasswordController.text,
        "new_password": newPasswordController.text,
      };
      await notifier.editPassword(context: context, body: body);
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<EditProfileNotifier>();
    final height = context.screenHeight;
        final size  = MediaQuery.of(context).size;

    return ModalProgressHUD(
      //inAsyncCall: isWaiting,
      inAsyncCall: notifier.loading,
      child: Scaffold(
        appBar: MyAppBar(text: "Password & Security"),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              children: [
                MyTextPoppines(
                  text:
                      "Your new password must be different from previously used ones.",
                  fontSize: height > 800 ? size.height * FontSize.fourteen : size.height * FontSize.sixteen,
                  fontWeight: FontWeight.w600,
                  height: height > 700 ? 1.2 : 1.4,
                ),
                10.vs,
                const Divider(
                  thickness: 1.0,
                ),
                10.vs,
                Form(
                  key: _editPasswordKey,
                  autovalidateMode: isSaveClicked
                      ? AutovalidateMode.onUserInteraction
                      : AutovalidateMode.disabled,
                  child: Column(
                    children: [
                      MyTextField(
                        text: "Current Password",
                        hintText: "Old Password",
                        controller: oldPasswordController,
                        validator: Validator().validatePassword,
                        focusNode: oldPassNode,
                        onSubmit: (p0) {
                          Utils.fieldFocusChange(
                              context, oldPassNode, newPassNode);
                        },
                      ),
                      MyTextField(
                        text: "Enter your new password",
                        hintText: "New Password",
                        controller: newPasswordController,
                        validator: Validator().validatePassword,
                        focusNode: newPassNode,
                        onSubmit: (p0) {
                          Utils.fieldFocusChange(
                              context, newPassNode, confrimPassNode);
                        },
                      ),
                      MyTextField(
                        text: "Confirm Password",
                        hintText: "Retype New Password",
                        controller: confirmPasswordController,
                        validator: (value) {
                          return Validator().validateConfirmPassword(
                            value: value,
                            valController: newPasswordController.text,
                          );
                        },
                        focusNode: confrimPassNode,
                      ),
                    ],
                  ),
                ),
                10.vs,
                const Divider(thickness: 1.0),
                20.vs,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            border: Border.all(color: AppColors.grey),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 42.w,
                            vertical: 15.h,
                          ),
                          child: Center(
                            child: MyTextPoppines(
                              text: "Discard",
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                      ),
                      MyBlueButton( 
                        hPadding: 42.w,
                        vPadding: 15.h,
                        fontSize: 18.sp,
                        text: " Save  ",
                        onTap: () => _editPasswordHandler(),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
