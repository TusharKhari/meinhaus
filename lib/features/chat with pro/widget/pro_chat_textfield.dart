// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:new_user_side/res/common/camera_view_page.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/extensions/get_images.dart';
import 'package:provider/provider.dart';

import '../../../provider/notifiers/chat_with_pro_notifier.dart';

class ProChatTextField extends StatefulWidget {
  const ProChatTextField({
    Key? key,
  }) : super(key: key);

  @override
  State<ProChatTextField> createState() => _ProChatTextFieldState();
}

class _ProChatTextFieldState extends State<ProChatTextField> {
  GetImages getImage = GetImages();

  // Send Img to Camera View
  Future selectImg(BuildContext context) async {
    final notifier = context.read<ChatWithProNotifier>();
    await getImage.pickImage<ChatWithProNotifier>(context: context);
    final imgPath = await notifier.image.path;
    Navigator.of(context).pushScreen(
      CameraViewPage(
        onTap: sendImgMessage,
        imgPath: imgPath,
      ),
    );
  }

  // Send Img as Message
  Future sendImgMessage() async {
    final notifier = context.read<ChatWithProNotifier>();
    await notifier.sendMessage(context: context);
    Navigator.pop(context);
  }

  // Pick Files function
  Future pickPdf(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (result != null && result.files.isNotEmpty) {
      String filePath = result.files.first.path!;
      print("filepath $filePath");
      return filePath;
    } else {
      return '';
    }
  }

  // Send Pdf as Message
  Future uploadPdf() async {
    final notifier = context.read<ChatWithProNotifier>();
    String filePath = await pickPdf(context);
    final multipartFile = await MultipartFile.fromFile(filePath);
    if (filePath.isNotEmpty) {
      await notifier.sendPdf(
        context: context,
        file: multipartFile,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ChatWithProNotifier>();
    final height = context.screenHeight;
    final width = context.screenWidth;
    return Container(
      width: double.infinity,
      height: height / 9,
      color: AppColors.white,
      child: Column(
        children: [
          const Divider(thickness: 1.0),
          SizedBox(height: height / 90),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 40),
            child: TextFormField(
              controller: notifier.messageController,
              onFieldSubmitted: (value) {},
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(width / 12),
                  borderSide: BorderSide(
                    color: AppColors.black.withOpacity(0.2),
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(width / 20),
                  borderSide: BorderSide(
                    color: AppColors.black.withOpacity(0.15),
                    width: 1.5,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: width / 20,
                  vertical: height / 90,
                ),
                hintText: "write a Meassage ",
                hintStyle: TextStyle(
                  fontSize: width / 28,
                  color: AppColors.black.withOpacity(0.4),
                ),
                prefixIcon: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return _bottomSheet(
                          onTapDoc: () => uploadPdf(),
                          onTapCamera: () {},
                          onTapGallery: () => sendImgMessage(),
                        );
                      },
                    );
                  },
                  child: Icon(
                    Icons.attach_file,
                    size: width / 20,
                    color: AppColors.black,
                  ),
                ),
                suffixIcon: InkWell(
                  onTap: () => notifier.sendMessage(context: context),
                  child: Icon(
                    Icons.send_sharp,
                    color: AppColors.buttonBlue,
                    size: width / 20,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _bottomSheet extends StatelessWidget {
  final VoidCallback onTapDoc;
  final VoidCallback onTapCamera;
  final VoidCallback onTapGallery;

  const _bottomSheet({
    Key? key,
    required this.onTapDoc,
    required this.onTapCamera,
    required this.onTapGallery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Container(
      height: h / 7.6,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: w / 30, vertical: h / 90),
      padding: EdgeInsets.only(top: h / 50),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(w / 30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildWorkers(
            context: context,
            backgroundColor: AppColors.buttonBlue,
            icon: Icons.insert_drive_file,
            title: "Document",
            onTap: onTapDoc,
          ),
          _buildWorkers(
            context: context,
            backgroundColor: Colors.red,
            icon: Icons.camera_alt,
            title: "Camera",
            onTap: onTapCamera,
          ),
          _buildWorkers(
            context: context,
            backgroundColor: Colors.purple,
            icon: Icons.insert_photo,
            title: "Gallary",
            onTap: onTapGallery,
          ),
        ],
      ),
    );
  }

  Widget _buildWorkers({
    required BuildContext context,
    required Color backgroundColor,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: w / 14,
            backgroundColor: backgroundColor,
            child: Icon(
              icon,
              size: w / 14,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: h / 160),
          MyTextPoppines(
            text: title,
            fontSize: w / 34,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
