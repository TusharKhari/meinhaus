// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_user_side/features/auth/screens/user_details.dart';
import 'package:new_user_side/res/common/buttons/my_bottom_bar_button.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/extensions/get_images.dart';
import 'package:new_user_side/utils/extensions/validator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../../provider/notifiers/address_notifier.dart';
import '../../../provider/notifiers/auth_notifier.dart';
import '../../../provider/notifiers/estimate_notifier.dart';
import '../../../res/common/my_app_bar.dart';
import '../../../res/common/my_snake_bar.dart';
import '../../../res/common/my_text.dart';

import '../../../utils/utils.dart';
import '../widget/saved_adresses_widget.dart';

class EstimateGenerationScreen extends StatefulWidget {
  static const String routeName = '/estimate';
  final bool? isNewEstimate;
  const EstimateGenerationScreen({
    Key? key,
    this.isNewEstimate = true,
  }) : super(key: key);

  @override
  State<EstimateGenerationScreen> createState() =>
      _EstimateGenerationScreenState();
}

String? selectedOption;

class _EstimateGenerationScreenState extends State<EstimateGenerationScreen> {
  final _estimateFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  FocusNode nameNode = FocusNode();
  FocusNode descNode = FocusNode();

  GetImages getImages = GetImages();

  Future getImagess() async {
    await getImages.pickImages<EstimateNotifier>(context: context);
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    descController.dispose();
    nameNode.dispose();
    descNode.dispose();
  }

  Future _createEstimateHandler() async {
    final estimateNotifer = context.read<EstimateNotifier>();
    final userProvider = context.read<AuthNotifier>().user.savedAddress;
    final addressProvider = context.read<AddressNotifier>();
    final image = await Utils.collectImages(estimateNotifer.images);
    final data = {
      'title': nameController.text,
      'description': descController.text,
      'time': selectedOption.toString(),
      'user_address_id': userProvider![addressProvider.index].id,
      'images[]': image,
    };
    if (_estimateFormKey.currentState!
        .validate()) if (estimateNotifer.images.length != 0) {
      await estimateNotifer.createEstimate(context: context, data: data);
    } else {
      showSnakeBar(context, "Please Select Img first");
    }
  }

  @override
  Widget build(BuildContext context) {
    final estimateNotifer = context.watch<EstimateNotifier>();
    return ModalProgressHUD(
      inAsyncCall: estimateNotifer.loading,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: MyAppBar(
            text:
                widget.isNewEstimate! ? "New Estimate" : "Estimate Generation"),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: _estimateFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextField(
                    text: "Name of your project",
                    hintText: "Fiting & fixing Window",
                    isHs20: false,
                    controller: nameController,
                    focusNode: nameNode,
                    onSubmit: (value) {
                       Utils.fieldFocusChange(context, nameNode, descNode);
                    },
                    validator: Validator().nullValidator,
                  ),
                  10.vs,
                  GenerateEstimateDropdown(),
                  MyTextField(
                    text: "Description of project",
                    maxLines: 5,
                    hintText: "Describe you project here ..!",
                    isHs20: false,
                    controller: descController,
                    focusNode: descNode,
                    validator: Validator().nullValidator,
                  ),
                  20.vs,
                  // Upload image colunm
                  Column(
                    children: [
                      MyTextPoppines(
                        text: " Upload pictures of the project",
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                      15.vs,
                      Padding(
                        padding: EdgeInsets.only(left: 25.w),
                        child: DottedBorder(
                          dashPattern: const [4, 6],
                          strokeCap: StrokeCap.round,
                          borderType: BorderType.RRect,
                          radius: Radius.circular(12.r),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                          color: AppColors.black.withOpacity(0.5),
                          child: SizedBox(
                            height: 90.h,
                            width: double.infinity,
                            child: Consumer<EstimateNotifier>(
                              builder: (context, images, child) {
                                final image = images.images;
                                return Row(
                                  children: [
                                    image.isEmpty
                                        ? Image.asset(
                                            "assets/icons/imgs.png",
                                            fit: BoxFit.fitWidth,
                                            width: 230.w,
                                          )
                                        : Expanded(
                                            child: ListView.builder(
                                              itemCount: image.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return Image.file(
                                                  File(image[index].path)
                                                      .absolute,
                                                );
                                              },
                                            ),
                                          ),
                                    20.hs,
                                    InkWell(
                                      onTap: () => getImagess(),
                                      child: Icon(
                                        Icons.add_circle,
                                        size: 35.sp,
                                        color: AppColors.textBlue,
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  20.vs,
                  const SavedAddressesWidget(),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Consumer<EstimateNotifier>(
          builder: (context, images, child) {
            return MyBottomNavWidget(
              hPadding: 60.w,
              text: "Create an Estimate",
              onTap: () => _createEstimateHandler(),
            );
          },
        ),
      ),
    );
  }
}

class GenerateEstimateDropdown extends StatefulWidget {
  const GenerateEstimateDropdown({super.key});

  @override
  State<GenerateEstimateDropdown> createState() =>
      _GenerateEstimateDropdownState();
}

class _GenerateEstimateDropdownState extends State<GenerateEstimateDropdown> {
  List<String> options = [
    'Less than one week',
    'Less than two weeks',
    'Less than a month',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextPoppines(
          text: "When would you like to have this tasks to be done? ",
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
          maxLines: 1,
        ),
        10.vs,
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: const Color.fromARGB(194, 240, 240, 240),
          ),
          child: DropdownButton<String>(
            value: selectedOption,
            borderRadius: BorderRadius.circular(16.r),
            isExpanded: true,
            underline: SizedBox(),
            items: options.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedOption = newValue!;
              });
            },
            hint: MyTextPoppines(
              text: "select the options",
              color: AppColors.black.withOpacity(0.8),
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
            style: GoogleFonts.poppins(
              color: AppColors.black.withOpacity(0.8),
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
