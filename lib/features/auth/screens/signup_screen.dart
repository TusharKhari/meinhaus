// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/data/network/network_api_servcies.dart';
import 'package:new_user_side/features/auth/screens/signin_screen.dart';
import 'package:new_user_side/features/auth/widgets/auth_banner_widget.dart';
import 'package:new_user_side/features/auth/widgets/auth_textfield.dart';
import 'package:new_user_side/provider/notifiers/auth_notifier.dart';
import 'package:new_user_side/res/common/buttons/my_buttons.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../utils/extensions/validator.dart';
import '../widgets/social_login_widget.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Key to validate form
  final _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool isWaiting = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  Future<void> signUp() async {
    final MapSS data = {
      "email": _emailController.text,
      "password": _confirmPasswordController.text,
    };
    final notifier = context.read<AuthNotifier>();
    if (_signUpFormKey.currentState!.validate()) {
      await notifier.signUp(data, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifer = context.watch<AuthNotifier>();
    return Scaffold(
      body: Column(
        children: [
          // Banner
          const AuthBannerWidget(isSignIn: false),
          20.vs,
          // Text fields
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: _signUpFormKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        AuthTextField(
                          controller: _emailController,
                          headingText: 'Email ID',
                          hintText: "email",
                          validator: Validator().validateEmail,
                        ),
                        15.vs,
                        AuthTextField(
                          controller: _passwordController,
                          headingText: 'Password',
                          hintText: "password",
                          validator: Validator().validatePassword,
                          isEmailField: false,
                        ),
                        15.vs,
                        AuthTextField(
                          controller: _confirmPasswordController,
                          headingText: 'Confirm Password',
                          hintText: "confirm Password",
                          validator: (val) {
                            return Validator().validateConfirmPassword(
                              value: val,
                              valController: _passwordController.text,
                            );
                          },
                          isEmailField: false,
                        )
                      ],
                    ),
                  ),
                  20.vs,
                  // Sing In Button
                  Divider(thickness: 1.5.w, indent: 10.w, endIndent: 10.w),
                  15.vs,
                  MyBlueButton(
                    hPadding: 120.w,
                    text: "Contiune",
                    isWaiting: notifer.loading,
                    onTap: () => signUp(),
                  ),
                  15.vs,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyTextPoppines(
                        text: "Already have an account ?",
                        fontSize: 13.sp,
                        color: AppColors.black.withOpacity(0.7),
                      ),
                      10.hs,
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, SignInScreen.routeName),
                        child: MyTextPoppines(
                          text: "Sign In",
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textBlue,
                        ),
                      ),
                    ],
                  ),
                  25.vs,
                  // Other options for login
                  const SocialLoginWidget(),
                  20.vs,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
