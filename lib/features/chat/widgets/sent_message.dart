import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../utils/download_files/download_file.dart';
import 'preview_chat_images.dart';

// SEND MESSAGES
class SendMessage extends StatelessWidget {
  final String sendText;
  final String timeOfText;
  final bool? isConvoEnd;
  final bool? isSeen;
  final int? messageState;
  final String? messageType;
  const SendMessage({
    Key? key,
    required this.sendText,
    required this.timeOfText,
    this.isConvoEnd = false,
    this.isSeen = false,
    this.messageState = 1,
    this.messageType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Container(
      margin: EdgeInsets.only(
        left: w / 4,
        top: h / 80,
        bottom: h / 80,
        right: w / 80,
      ),
      padding: EdgeInsets.symmetric(horizontal: w / 28, vertical: h / 80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(w / 20),
          topRight: Radius.circular(w / 20),
          bottomLeft: Radius.circular(w / 20),
        ),
        color: isConvoEnd!
            ? AppColors.yellow.withOpacity(0.12)
            : const Color(0xFF22577A).withOpacity(0.7),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (sendText.contains("Reason for denying"))
            SizedBox(
              width: w / 1.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextPoppines(
                    text: "Reason for denying : ",
                    fontSize: w / 32,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                    maxLines: 100,
                  ),
                  SizedBox(height: h / 200),
                  MyTextPoppines(
                    text: sendText,
                    fontSize: w / 32,
                    fontWeight: FontWeight.w500,
                    color: isConvoEnd! ? AppColors.black : AppColors.white,
                    maxLines: 100,
                  ),
                ],
              ),
            )
          else
            mType(messageType!, context),
          MyTextPoppines(
            text: timeOfText,
            fontSize: w / 32,
            fontWeight: FontWeight.w500,
            color: isConvoEnd!
                ? AppColors.black.withOpacity(0.6)
                : AppColors.white.withOpacity(0.6),
            maxLines: 20,
          ),
          Icon(
            setIcon(messageState!),
            size: w / 25,
            color: setIconColor(messageState!),
          )
        ],
      ),
    );
  }

  Widget mType(String type, BuildContext context) {
    final w = context.screenWidth;
    final textMessage = SizedBox(
      width: w / 1.9,
      child: MyTextPoppines(
        text: sendText,
        fontSize: w / 32,
        fontWeight: FontWeight.w500,
        color: isConvoEnd! ? AppColors.black : AppColors.white,
        maxLines: 100,
      ),
    );
    final pdfMessage = DownloadFile(fileNmae: sendText);
    final imgMessage = SizedBox(
      width: w / 1.9,
      child: InkWell(
        onTap: () => Navigator.of(context).pushScreen(
          PreviewChatImages(imgPath: sendText),
        ),
        child: Hero(
          tag: sendText,
          child: CachedNetworkImage(
            imageUrl: sendText,
            errorWidget: (context, url, error) => Icon(
              Icons.image_not_supported,
              size: w / 10,
              color: Colors.red[900],
            ),
            placeholder: (context, url) => Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: LoadingAnimationWidget.inkDrop(
                  color: AppColors.black,
                  size: w / 26,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    switch (type) {
      case "text":
        return textMessage;
      case "pdf":
        return pdfMessage;
      case "png":
        return imgMessage;
      case "jpg":
        return imgMessage;
      case "webp":
        return imgMessage;
      default:
        return textMessage;
    }
  }

  IconData setIcon(int messageState) {
    switch (messageState) {
      case 0:
        return Icons.access_time_outlined;
      case 1:
        return Icons.done_all;
      case 2:
        return Icons.done_all;
      case 3:
        return Icons.error_outline;
      default:
        return Icons.done;
    }
  }

  Color setIconColor(int messageState) {
    switch (messageState) {
      case 0:
        return Colors.white;
      case 1:
        return Colors.white;
      case 2:
        return Colors.lightBlue;
      case 3:
        return Colors.red;
      default:
        return Colors.white;
    }
  }
}
