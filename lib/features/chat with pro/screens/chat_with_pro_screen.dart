// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import 'package:new_user_side/data/models/conversation_list_model.dart';
import 'package:new_user_side/res/common/camera_view_page.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/extensions/get_images.dart';

import '../../../data/network/network_api_servcies.dart';
import '../../../provider/notifiers/chat_with_pro_notifier.dart';
import '../../../utils/utils.dart';
import '../../customer support/screens/customer_support_chat_screen.dart';

class ChatWithProScreen extends StatefulWidget {
  static const String routeName = '/chatwithpro';
  const ChatWithProScreen({
    Key? key,
    required this.sendUserId,
    required this.conversations,
  }) : super(key: key);
  final String sendUserId;
  final Conversations conversations;

  @override
  State<ChatWithProScreen> createState() => _ChatWithProScreenState();
}

class _ChatWithProScreenState extends State<ChatWithProScreen> {
  late ChatWithProNotifier notifier;
  @override
  void initState() {
    super.initState();
    loadMessages();
  }

  @override
  void didChangeDependencies() {
    notifier = context.read<ChatWithProNotifier>();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    notifier.proMessages.messages!.clear();
  }

  void clearMessage() {
    final notifier = context.read<ChatWithProNotifier>();
    notifier.proMessages.messages!.clear();
  }

  Future setupPusherChannel() async {
    final notifier = context.read<ChatWithProNotifier>();
    await notifier.setupPusher(context);
  }

  Future loadMessages() async {
    final notifier = context.read<ChatWithProNotifier>();
    MapSS body = {"to_user_id": widget.sendUserId};
    await notifier.loadMessages(context: context, body: body);
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ChatWithProNotifier>();
    final h = context.screenHeight;
    final w = context.screenWidth;
    return notifier.proMessages.messages != null
        ? ModalProgressHUD(
            inAsyncCall: notifier.loading,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size(w, h / 14),
                child: ProChatAppBar(
                  senderImg: widget.conversations.profilePicture!,
                  senderName: widget.conversations.toUserName!,
                ),
              ),
              body: Stack(
                children: [
                  Column(
                    children: [
                      ProjectDetailsBlock(
                        projectNmae: widget.conversations.projectName,
                        projectId: widget.conversations.estimateServiceId,
                        projectStartedDate:
                            widget.conversations.projectStartedOn,
                      ),
                      notifier.proMessages.messages!.length > 0
                          ? Expanded(
                              child: NotificationListener<ScrollNotification>(
                                onNotification: (scrollNotification) {
                                  if (scrollNotification
                                      is ScrollEndNotification) {
                                    if (notifier
                                            .scrollController.position.pixels ==
                                        notifier.scrollController.position
                                            .minScrollExtent) {
                                      notifier.loadMoreMessages(context);
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
                                    itemCount:
                                        notifier.proMessages.messages!.length,
                                    itemBuilder: (context, index) {
                                      final messages = notifier.proMessages;
                                      final message = messages.messages![index];
                                      final messageState = message.isSeen;
                                      final messageType = message.type;
                                      final createdAt = message.createdAt;
                                      final messageTime =
                                          Utils.convertToRailwayTime(
                                              "$createdAt");
                                      if (message.senderId.toString() ==
                                          widget.sendUserId) {
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
                ],
              ),
              bottomSheet: const ProChatButtomSheet(),
            ),
          )
        : ModalProgressHUD(inAsyncCall: true, child: Scaffold());
  }
}

class ProjectDetailsBlock extends StatelessWidget {
  final String? projectNmae;
  final String? projectId;
  final String? projectStartedDate;
  const ProjectDetailsBlock({
    Key? key,
    this.projectNmae,
    this.projectId,
    this.projectStartedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Container(
      color: AppColors.yellow.withOpacity(0.15),
      padding: EdgeInsets.symmetric(horizontal: w / 20, vertical: h / 70),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTextPoppines(
                text: projectNmae ?? "Furniture Fixing",
                fontSize: w / 28,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: h / 200),
              MyTextPoppines(
                text: projectId ?? "OD-79E9646",
                fontSize: w / 40,
                color: AppColors.yellow,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          MyTextPoppines(
            text: projectStartedDate != null
                ? "Project Started On : $projectStartedDate"
                : "Project Started On : 15/02/2023",
            fontSize: w / 34,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}

class NoMessageYetWidget extends StatelessWidget {
  const NoMessageYetWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(w / 20),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(12, 0, 0, 0),
            offset: const Offset(0, 0),
            blurRadius: w / 40,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: w / 10,
        vertical: h / 20,
      ),
      margin: EdgeInsets.only(top: h / 7),
      child: Column(
        children: [
          MyTextPoppines(
            text: "No Messages yet..!",
            fontSize: w / 20,
            color: AppColors.yellow,
          ),
          SizedBox(height: h / 40),
          MyTextPoppines(
            text: "Send a message to \n     chat with Pro..!",
            fontSize: w / 24,
            color: AppColors.black.withOpacity(0.4),
          ),
          SizedBox(height: h / 40),
          SizedBox(
            height: h / 8,
            width: w / 2,
            child: Image.asset("assets/icons/message.png"),
          ),
        ],
      ),
    );
  }
}

class ProChatAppBar extends StatelessWidget {
  const ProChatAppBar({
    Key? key,
    required this.senderName,
    required this.senderImg,
  }) : super(key: key);
  final String senderName;
  final String senderImg;

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return AppBar(
      backgroundColor: Colors.white,
      leading: InkWell(
        onTap: () => Navigator.pop(context),
        child: Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.black,
          size: w / 20,
        ),
      ),
      titleSpacing: 0,
      elevation: 0.0,
      title: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: w / 22,
                backgroundImage: senderImg.isEmpty
                    ? AssetImage("assets/images/face/man_1.png")
                    : NetworkImage(senderImg) as ImageProvider<Object>,
              ),
              Positioned(
                right: 0,
                top: h / 300,
                child: CircleAvatar(
                  radius: w / 100,
                  backgroundColor: AppColors.green,
                ),
              ),
            ],
          ),
          SizedBox(width: w / 40),
          MyTextPoppines(
            text: senderName,
            fontSize: w / 28,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
      actions: [
        Icon(
          CupertinoIcons.ellipsis_vertical,
          color: AppColors.black,
          size: w / 22,
        ),
        SizedBox(width: w / 40),
      ],
    );
  }
}

class ProChatButtomSheet extends StatefulWidget {
  const ProChatButtomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<ProChatButtomSheet> createState() => _ProChatButtomSheetState();
}

class _ProChatButtomSheetState extends State<ProChatButtomSheet> {
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

  Future sendImgMessage() async {
    final notifier = context.read<ChatWithProNotifier>();
    await notifier.sendMessage(context: context);
    Navigator.pop(context);
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
                  onTap: () => selectImg(context),
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
