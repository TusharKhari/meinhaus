// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:new_user_side/features/home/screens/home_screen.dart';
import 'package:new_user_side/provider/notifiers/chat_with_suport_notifier.dart';
import 'package:new_user_side/provider/notifiers/estimate_notifier.dart';
import 'package:new_user_side/res/common/buttons/my_buttons.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../provider/notifiers/auth_notifier.dart';
import '../../../utils/download_files/download_file.dart';
import '../../../utils/utils.dart';
import '../../chat with pro/widget/chat_no_message_yet.dart';
import '../../chat with pro/widget/chat_project_details_block.dart';
import '../../chat with pro/widget/pro_chat_textfield.dart';

class CustomerSupportChatScreen extends StatefulWidget {
  static const String routeName = '/supportChat';
  const CustomerSupportChatScreen({super.key});

  @override
  State<CustomerSupportChatScreen> createState() =>
      _CustomerSupportChatScreenState();
}

class _CustomerSupportChatScreenState extends State<CustomerSupportChatScreen> {
  late ChatWithSupportNotifier notifier;
  @override
  void initState() {
    super.initState();
    loadMessages();
  }

  @override
  void didChangeDependencies() {
    notifier = context.read<ChatWithSupportNotifier>();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    notifier.supportMessages.messages!.clear();
  }

  void clearMessage() {
    final notifier = context.read<ChatWithSupportNotifier>();
    notifier.supportMessages.messages!.clear();
  }

  Future loadMessages() async {
    final notifier = context.read<ChatWithSupportNotifier>();
    await notifier.loadMessages(context);
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ChatWithSupportNotifier>();
    final userNotifier = context.read<AuthNotifier>().user;
    final projectNotifier = context.read<EstimateNotifier>();
    final projectDeatils = projectNotifier.projectDetails.services;
    final h = context.screenHeight;
    final w = context.screenWidth;

    return notifier.supportMessages.messages != null
        ? ModalProgressHUD(
            inAsyncCall: notifier.loading,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.white,
                elevation: 0.0,
                leading: Image.asset("assets/icons/support_2.png"),
                titleSpacing: 4.0,
                title:
                    MyTextPoppines(text: "Customer support", fontSize: w / 22),
                actions: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: h / 70),
                      padding: EdgeInsets.symmetric(horizontal: w / 70),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(w / 40),
                        border: Border.all(
                          width: 1.0,
                          color: AppColors.grey.withOpacity(0.4),
                        ),
                      ),
                      child: Icon(
                        CupertinoIcons.xmark,
                        color: AppColors.black,
                        size: w / 22,
                      ),
                    ),
                  ),
                  SizedBox(width: w / 30),
                ],
              ),
              body: Stack(
                children: [
                  Column(
                    children: [
                      ProjectDetailsBlock(
                        projectNmae: projectDeatils!.projectName,
                        projectId: projectDeatils.estimateNo,
                        projectStartedDate: projectDeatils.projectStartDate,
                      ),
                      notifier.supportMessages.messages!.length > 0
                          ? Expanded(
                              child: NotificationListener<ScrollNotification>(
                                onNotification: (scrollNotification) {
                                  if (scrollNotification
                                      is ScrollEndNotification) {
                                    if (notifier
                                            .scrollController.position.pixels ==
                                        notifier.scrollController.position
                                            .minScrollExtent) {
                                      // notifier.loadMoreMessages(context);
                                    }
                                  }
                                  return false;
                                },
                                child: Scrollbar(
                                  thumbVisibility: true,
                                  controller: notifier.scrollController,
                                  child: ListView.builder(
                                    controller: notifier.scrollController,
                                    padding: EdgeInsets.only(bottom: h / 10),
                                    itemCount: notifier
                                        .supportMessages.messages!.length,
                                    itemBuilder: (context, index) {
                                      final messages = notifier.supportMessages;
                                      final message = messages.messages![index];
                                      final messageState = message.isSeen;
                                      final messageType = message.type;
                                      final createdAt = message.createdAt;
                                      final messageTime =
                                          Utils.convertToRailwayTime(
                                              "$createdAt");
                                      if (message.senderId.toString() !=
                                          userNotifier.userId.toString()) {
                                        return RecivedMessage(
                                          sendText: message.message!,
                                          timeOfText: messageTime,
                                          messageType: messageType,
                                        );
                                      } else {
                                        return SendMessage(
                                          isConvoEnd: false,
                                          sendText: message.message!,
                                          timeOfText: messageTime,
                                          messageState: messageState,
                                          messageType: messageType,
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            )
                          : NoMessageYetWidget(),
                    ],
                  ),
                  // load more message loading indicator
                  Positioned(
                    left: w / 2.2,
                    top: h / 12,
                    child: notifier.loadMoreLoading
                        ? LoadingAnimationWidget.bouncingBall(
                            color: AppColors.black,
                            size: w / 20,
                          )
                        : SizedBox(),
                  ),
                  // message text field
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ProChatTextField(),
                  ),
                ],
              ),
            ),
          )
        : ModalProgressHUD(inAsyncCall: true, child: Scaffold());
  }
}

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
          child: Image.network(sendText),
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

// RECIVED MESSAGES
class RecivedMessage extends StatelessWidget {
  final String sendText;
  final String timeOfText;
  final String? messageType;
  const RecivedMessage({
    Key? key,
    required this.sendText,
    required this.timeOfText,
    this.messageType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Row(
      children: [
        SizedBox(width: w / 38),
        // Sender Img
        Image.asset(
          "assets/icons/support_2.png",
          height: h / 30,
          width: w / 15,
        ),
        SizedBox(width: w / 80),
        // Message
        Container(
          margin: EdgeInsets.only(
            left: w / 38,
            top: h / 80,
            bottom: h / 80,
            right: w / 6,
          ),
          padding: EdgeInsets.symmetric(horizontal: w / 30, vertical: h / 80),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(w / 20),
              topRight: Radius.circular(w / 20),
              bottomRight: Radius.circular(w / 20),
            ),
            color: const Color(0xFFC1C1C1).withOpacity(0.20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              mType(messageType!, context),
              SizedBox(width: w / 60),
              MyTextPoppines(
                text: timeOfText,
                fontSize: w / 32,
                fontWeight: FontWeight.w500,
                color: AppColors.black.withOpacity(0.6),
                maxLines: 20,
              ),
            ],
          ),
        ),
      ],
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
        color: AppColors.black,
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
          child: Image.network(sendText),
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
      default:
        return textMessage;
    }
  }
}

// BACK TO HOME BUTTON
class CustomerEndConvoBottomSheet extends StatelessWidget {
  const CustomerEndConvoBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Container(
      width: double.infinity,
      height: h / 5,
      margin: EdgeInsets.symmetric(horizontal: w / 12, vertical: h / 25),
      padding: EdgeInsets.symmetric(horizontal: w / 10, vertical: h / 80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(w / 26),
        color: AppColors.yellow.withOpacity(0.12),
      ),
      child: Column(
        children: [
          SizedBox(height: 18),
          MyTextPoppines(
            text: "Conversion has been ended succesfully...!",
            fontSize: w / 26,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 18),
          MyBlueButton(
            hPadding: w / 10,
            fontSize: w / 26,
            text: "Back To Home",
            onTap: () {
              context.pushNamedRoute(HomeScreen.routeName);
            },
            vPadding: h / 60,
          )
        ],
      ),
    );
  }
}

class PreviewChatImages extends StatelessWidget {
  final String imgPath;
  const PreviewChatImages({
    Key? key,
    required this.imgPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: w / 22,
          ),
        ),
        title: MyTextPoppines(
          text: "Preview Image",
          color: AppColors.white,
          fontSize: w / 22,
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: InteractiveViewer(
            child: Hero(
              tag: imgPath,
              child: Image.network(
                imgPath,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
