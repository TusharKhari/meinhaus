// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
 import 'package:new_user_side/features/auth/screens/signin_screen.dart';
import 'package:new_user_side/features/auth/screens/signup_secondstep_screen.dart';
import 'package:new_user_side/features/auth/widgets/auth_banner_widget.dart';
import 'package:new_user_side/features/auth/widgets/auth_textfield.dart';
import 'package:new_user_side/provider/notifiers/auth_notifier.dart';
import 'package:new_user_side/resources/common/buttons/my_buttons.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../resources/font_size/font_size.dart';
import '../../../utils/extensions/validator.dart';
import '../widgets/social_login_widget.dart';

class SignUpStepFirstScreen extends StatefulWidget {
  static const String routeName = '/signup-first';
  const SignUpStepFirstScreen({super.key});

  @override
  State<SignUpStepFirstScreen> createState() => _SignUpStepFirstScreenState();
}

class _SignUpStepFirstScreenState extends State<SignUpStepFirstScreen> {
  // Key to validate form
  final _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isSignUpClicked = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void _signUpHandler(BuildContext context) async {
  if(mounted) setState(() {
      isSignUpClicked = true;
   });
       if (_signUpFormKey.currentState!.validate()) {
         isSignUpClicked = false;
      Navigator.of(context).pushScreen(
        SignUpStepSecondScreen(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    
    } 
   
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<AuthNotifier>();
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
        final size  = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          // Banner
          const AuthBannerWidget(isSignIn: false),
          SizedBox(height: height / 40),
          // Text fields
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: MyTextPoppines(
                      text: "Step 1     ",
                      fontSize: size.height * FontSize.sixteen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Form(
                    key: _signUpFormKey,
                    autovalidateMode: isSignUpClicked ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                    child: Column(
                      children: [
                        AuthTextField(
                          controller: _emailController,
                          headingText: 'Email ID',
                          hintText: "email",
                          validator: Validator().validateEmail,
                        ),
                        SizedBox(height: height / 50),
                        AuthTextField(
                          controller: _passwordController,
                          headingText: 'Password',
                          hintText: "password",
                          validator: Validator().validatePassword,
                          isEmailField: false,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height / 30),
                  // Sing In Button
                  Divider(
                    thickness: 1.5,
                    indent: width / 50,
                    endIndent: width / 50,
                  ),
                  SizedBox(height: height / 50),
                  MyBlueButton(
                    hPadding: width / 3,
                    text: "Next",
                    isWaiting: notifier.loading,
                    onTap: () => _signUpHandler(context),
                  ),
                  SizedBox(height: height / 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyTextPoppines(
                        text: "Already have an account ?",
                        fontSize: size.height * FontSize.fourteen,
                        color: AppColors.black.withOpacity(0.7),
                      ),
                      SizedBox(width: width / 40),
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, SignInScreen.routeName),
                        child: MyTextPoppines(
                          text: "Sign In",
                          fontSize: size.height * FontSize.sixteen,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textBlue,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height / 30),
                  // Other options for login
                  const SocialLoginWidget(),
                  SizedBox(height: height / 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
