import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:new_user_side/features/auth/widgets/my_text_field.dart';
import 'package:new_user_side/features/estimate/widget/saved_adresses_widget.dart';
import 'package:new_user_side/provider/notifiers/address_notifier.dart';
import 'package:new_user_side/provider/notifiers/auth_notifier.dart';
import 'package:new_user_side/resources/common/buttons/my_bottom_bar_button.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/extensions/show_picked_images.dart';
import 'package:provider/provider.dart';
import '../../../provider/notifiers/estimate_notifier.dart';
import '../../../resources/common/my_snake_bar.dart';
import '../../../resources/font_size/font_size.dart';
import '../../../utils/extensions/validator.dart';
import '../../../utils/utils.dart';
import '../../estimate/screens/estimate_generation_screen.dart';
import '../../estimate/widget/bottom_sheet.dart';
import '../../home/screens/home_screen.dart';
import '../widgets/user_details_toggle_button.dart';

class CreateStartingProject extends StatefulWidget {
  const CreateStartingProject({super.key});

  @override
  State<CreateStartingProject> createState() => _CreateStartingProjectState();
}

class _CreateStartingProjectState extends State<CreateStartingProject> {
  // Form key to validate all the textfeilds
  final _estimateFormKey = GlobalKey<FormState>();

  // All Controller to saved values form user input
  TextEditingController addressController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // Focus node to shift the focus from one textfield to another
  FocusNode nameNode = FocusNode();
  FocusNode descNode = FocusNode();

  // Deafult selected address is null
  String selectedAddress = '';
  String placeId = "";
  bool isSubmitClicked = false;

  @override
  void initState() {
    super.initState();
    addressController.addListener(() {
      onChange();
    });
  }

  @override
  void dispose() {
    super.dispose();
    addressController.dispose();
  }

  // Getting all the address suggestion according to address controller
  void onChange() {
    final notifier = context.read<AddressNotifier>();
    notifier.getAddressSuggestions(addressController.text);
  }

  // After verfication user can able to create its first project/estimate
  Future<void> createStartingProject() async {
    final userNotier = context.read<AuthNotifier>();
    final notifier = context.read<EstimateNotifier>();
    final image = await Utils.collectImages(notifier.images);
    //  final image = GetImages().pickImages<EstimateNotifier>(context: context);
    final userAddress = userNotier.user.savedAddress![0];
    final data = {
      'title': titleController.text,
      'description': descriptionController.text,
      'time': selectedOption.toString(),
      'user_address_id': userAddress.id.toString(),
      'images[]': image,
    };
    await notifier.createStartingEstimate(context: context, data: data);
  }

  @override
  Widget build(BuildContext context) {
    final estimateNotifer = context.watch<EstimateNotifier>();
    final authNotifer = context.watch<AuthNotifier>();

    // Mediaquerys for responsiveness
    final h = context.screenHeight;
    final w = context.screenWidth;
    final size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: estimateNotifer.loading,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title -> Headline + Skip button
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: w / 20,).copyWith(top: h / 90),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyTextPoppines(
                          text: "Start your project",
                          fontSize: 20.sp,
                          // fontSize: w / 24,
                          fontWeight: FontWeight.w700,
                        ),
                        //  SizedBox(height: h / 130),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(
                          HomeScreen.routeName,
                        );
                      },
                      child: Text(
                        "Skip",
                        style: GoogleFonts.poppins(
                          fontSize: size.height * FontSize.fourteen,
                          // fontSize: w / 28,
                          color: AppColors.buttonBlue,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              MyTextPoppines(
                text: "   We will provide you an estimate right away",
                fontSize: 13.sp,

                // fontSize: w / 34,
                fontWeight: FontWeight.w500,
                color: AppColors.grey,
                maxLines: 2,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: w / 20),
                    child: Form(
                      key: _estimateFormKey,
                      autovalidateMode: isSubmitClicked
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title textfield
                          MyTextField(
                            text: "Title",
                            hintText: "Project title",
                            isHs20: false,
                            focusNode: nameNode,
                            controller: titleController,
                            onSubmit: (value) {
                              Utils.fieldFocusChange(
                                context,
                                nameNode,
                                descNode,
                              );
                            },
                            validator: Validator().nullValidator,
                          ),
                          SizedBox(height: h / 130),
                          // Description textfield
                          MyTextField(
                            text: "Description",
                            hintText: "Project description",
                            maxLines: 4,
                            isHs20: false,
                            controller: descriptionController,
                            focusNode: descNode,
                            validator: Validator().nullValidator,
                          ),
                          SizedBox(height: h / 100),
                          // [Dropdwon] When would you like to have this task to be done?
                          GenerateEstimateDropdown(),
                          // SizedBox(height: h / 80),
                          SizedBox(
                            height: 20.h,
                          ),

                          SavedAddressesWidget(),

                          // Upload Images Section
                          SizedBox(height: h / 50),
                          MyTextPoppines(
                            text: "Upload clear photos of project area",
                            fontSize: size.height * FontSize.fourteen,
                            // fontSize: w / 34,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: h / 80),
                          estimateNotifer.images.isEmpty
                              ? InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) {
                                        return BottomSheetSelectImagesOption(
                                          onTapGallery: () => estimateNotifer
                                              .getImagess(context),
                                          onTapCamera: () async {
                                            await estimateNotifer
                                                .selectImgFromCamera(context);
                                          },
                                        );
                                      },
                                    );
                                  },
                                  // onTap: () =>
                                  //     estimateNotifer.getImagess(context),
                                  child: Container(
                                    width: w / 6,
                                    height: h / 12.5,
                                    decoration: BoxDecoration(
                                      color: AppColors.grey.withOpacity(0.2),
                                      borderRadius:
                                          BorderRadius.circular(w / 30),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: w / 14,
                                    ),
                                  ),
                                )
                              : ShowPickedImages<EstimateNotifier>(),
                          SizedBox(height: h / 80),
                          MyTextPoppines(
                            text: "You can select multiple images",
                            fontSize: size.height * FontSize.twelve,
                            // fontSize: w / 36,
                            fontWeight: FontWeight.w500,
                            color: AppColors.golden,
                          ),
                          SizedBox(height: h / 80),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Terms and Condition Block
              Container(
                width: double.infinity,
                padding:
                    EdgeInsets.symmetric(horizontal: w / 50, vertical: h / 40),
                color: const Color(0xFFF0F8FF),
                child: Row(
                  children: [
                    SizedBox(width: w / 20),
                    SizedBox(
                      width: w / 1.5,
                      child: Text.rich(
                        TextSpan(
                          text:
                              'By Signing Up with MeinHaus you agree with our ',
                          style: TextStyle(
                            fontSize: size.height * FontSize.twelve,
                            // fontSize: h / 55,
                          ),
                          children: [
                            TextSpan(
                              text: 'Terms & Conditions',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.height * FontSize.fourteen,
                                // fontSize: w / 30,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                            TextSpan(
                              text: ' and ',
                              style: TextStyle(
                                fontSize: size.height * FontSize.fourteen,
                                // fontSize: w / 30,
                              ),
                            ),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.height * FontSize.fourteen,
                                // fontSize: w / 30,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: w / 20),
                    UserDeatilsToggleButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Submit button
        bottomNavigationBar: MyBottomNavWidget(
          hPadding: w / 4,
          text: "Submit",
          onTap: () {
            if (mounted)
              setState(() {
                isSubmitClicked = true;
              });
            if (_estimateFormKey.currentState!.validate()) {
              isSubmitClicked = false;
              authNotifer.isToggle
                  ? createStartingProject()
                  : showSnakeBarr(
                      context,
                      "Please Accept T&C",
                      SnackBarState.Warning,
                    );
              ;
              ;
            }
          },
        ),
      ),
    );
  }
}
