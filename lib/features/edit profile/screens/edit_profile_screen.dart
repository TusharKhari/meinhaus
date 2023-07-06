// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_user_side/provider/notifiers/auth_notifier.dart';
import 'package:new_user_side/features/edit%20profile/controller/provider/edit_profile_notifier.dart';
import 'package:new_user_side/features/edit%20profile/controller/services/edit_profile_services.dart';
import 'package:new_user_side/res/common/my_app_bar.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/sizer.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../../res/common/buttons/my_buttons.dart';
import '../../../static componets/dialogs/edit_profile_dialog.dart';
import '../../../utils/extensions/get_images.dart';
import '../../estimate/widget/saved_adresses_widget.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName = '/edit';
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  EditProfileServices profileServices = EditProfileServices();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  GetImages getImages = GetImages();

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthNotifier>().user;
    firstNameController = TextEditingController(text: user.firstname);
    lastNameController = TextEditingController(text: user.lastname);
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
  }

  Future getImagess() async {
    await getImages.pickImage<EditProfileNotifier>(context: context);
  }

  _editProfileHandler() async {
    final notifier = context.read<EditProfileNotifier>();
    await notifier.editProfile(
      context: context,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthNotifier>().user;
    final notifier = context.watch<EditProfileNotifier>();
    print(user.profilePic);

    String userName = "${user.firstname} ${user.lastname}";
    final img = notifier.image;
    return ModalProgressHUD(
      inAsyncCall: notifier.loading,
      child: Scaffold(
        appBar: MyAppBar(
          text: "Edit Profile",
          onBack: () {
            notifier.image.path.isNotEmpty
                ? showDialog(
                    context: context,
                    builder: (context) {
                      return EditProfilePicDialog(
                        onTapAtOk: () async {
                          notifier.setProfileImg(XFile(""));
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      );
                    },
                  )
                : Navigator.pop(context);
          },
        ),
        body: Column(
          children: [
            10.vs,
            Row(
              children: [
                30.hs,
                CircleAvatar(
                  radius: 40.r,
                  backgroundImage: img.path.isNotEmpty
                      ? Image.file(File(img.path)).image
                      : user.profilePic!.length > 0
                          ? NetworkImage(user.profilePic!.toString())
                              as ImageProvider<Object>?
                          : AssetImage("assets/images/man.png"),
                ),
                20.hs,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: context.screenWidth / 1.6,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        child: MyTextPoppines(
                          text: userName,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    10.vs,
                    // Change Profile button
                    InkWell(
                      onTap: () => getImagess(),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 10.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColors.textBlue1E9BD0.withOpacity(0.12),
                        ),
                        child: Row(
                          children: [
                            MyTextPoppines(
                              text: "Change Profile",
                              color: AppColors.textBlue1E9BD0,
                              fontSize:
                                  context.screenHeight / MyFontSize.font10,
                              fontWeight: FontWeight.w500,
                            ),
                            10.hs,
                            Icon(
                              Icons.camera_alt_outlined,
                              color: AppColors.textBlue1E9BD0,
                              size: 16.sp,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            10.vs,
            Divider(thickness: 1.5, indent: 20.w, endIndent: 20.w),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.vs,
                      // Basic info edit card
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            width: 0.8,
                            color: AppColors.black.withOpacity(0.2),
                          ),
                          color: AppColors.white,
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(12, 0, 0, 0),
                              offset: const Offset(0, 4),
                              blurRadius: 10.r,
                              spreadRadius: 2.r,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 5.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            15.vs,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyTextPoppines(
                                  text: "Basic Info",
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                MyBlueButton(
                                  hPadding: 20.w,
                                  vPadding: 10.h,
                                  text: "Update Profile",
                                  fontSize: 10.sp,
                                  onTap: () => _editProfileHandler(),
                                ),
                              ],
                            ),
                            10.vs,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Column(
                                children: [
                                  10.vs,
                                  _TextField(
                                    hText: "First Name",
                                    hintText: user.firstname.toString(),
                                    controller: firstNameController,
                                    onSaved: (val) {},
                                  ),
                                  _TextField(
                                    hText: "Last Name",
                                    hintText: user.lastname.toString(),
                                    controller: lastNameController,
                                    onSaved: (val) {},
                                  ),
                                  _TextField(
                                    hText: "Mobile No",
                                    hintText: "(+1) ${user.contact}",
                                    isEditable: false,
                                  ),
                                  _TextField(
                                    hText: "Email ID",
                                    hintText: user.email.toString(),
                                    isEditable: false,
                                  ),
                                  10.vs,
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      20.vs,
                      Divider(thickness: 1.5, indent: 20.w, endIndent: 20.w),
                      20.vs,
                      const SavedAddressesWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  final String hText;
  final String hintText;
  final bool? isEditable;
  final TextEditingController? controller;
  final Function(String?)? onSaved;
  const _TextField({
    Key? key,
    required this.hText,
    required this.hintText,
    this.isEditable = true,
    this.controller,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTextPoppines(
            text: hText,
            fontSize: context.screenHeight / MyFontSize.font12,
          ),
          SizedBox(
            height: 35.h,
            child: TextFormField(
              controller: controller,
              enabled: isEditable,
              style: GoogleFonts.poppins(
                fontSize: context.screenHeight / MyFontSize.font12,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 10.h),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.grey.withOpacity(0.4),
                    width: 0.7,
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: AppColors.textBlue1E9BD0,
                  width: 0.7,
                )),
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: context.screenHeight / MyFontSize.font12,
                ),
              ),
              onSaved: onSaved,
            ),
          ),
        ],
      ),
    );
  }
}
