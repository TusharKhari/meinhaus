import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:new_user_side/features/auth/screens/user_details.dart';
import 'package:new_user_side/res/common/buttons/my_buttons.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/extensions/validator.dart';

import '../../../res/common/my_text.dart';
import '../../../utils/constants/app_colors.dart';
import '../widgets/auth_textfield.dart';
import '../widgets/phone_number_textfield.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _confrimPassController = TextEditingController();
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w / 20),
          child: Column(
            children: [
              SizedBox(height: h / 80),
              // Kind of App bar
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: w / 10,
                      height: h / 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(w / 40),
                        border: Border.all(
                          width: 1.5,
                          color: AppColors.grey.withOpacity(0.4),
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.black,
                        size: w / 26,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: w / 4, top: h / 80),
                    child: Image.asset(
                      "assets/logo/home.png",
                      fit: BoxFit.cover,
                      width: w / 5,
                      height: h / 13,
                    ),
                  ),
                ],
              ),
              SizedBox(height: h / 30),
              Align(
                alignment: Alignment.topLeft,
                child: MyTextPoppines(
                  text: "Create New Password",
                  fontSize: w / 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: h / 30),
              AuthTextField(
                controller: _passwordController,
                headingText: 'Password',
                hintText: "password",
                validator: Validator().validatePassword,
                isEmailField: false,
                isHs20: false,
              ),
              SizedBox(height: h / 30),
              AuthTextField(
                controller: _confrimPassController,
                headingText: 'Confrim Password',
                hintText: "confirm password",
                isEmailField: false,
                isHs20: false,
                validator: (value) => Validator().validateConfirmPassword(
                  value: value,
                  valController: _passwordController.text,
                ),
              ),

              SizedBox(height: h / 40),
              Divider(thickness: 1.0),
              SizedBox(height: h / 80),
              MyBlueButton(
                hPadding: w / 6,
                text: "Reset Password",
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
