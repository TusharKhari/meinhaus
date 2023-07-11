// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:new_user_side/data/models/conversation_list_model.dart';
import 'package:new_user_side/features/chat%20with%20pro/widget/pro_chat_textfield.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../data/network/network_api_servcies.dart';
import '../../../provider/notifiers/chat_with_pro_notifier.dart';
import '../../../utils/utils.dart';
import '../../customer support/screens/customer_support_chat_screen.dart';
import '../widget/chat_no_message_yet.dart';
import '../widget/chat_project_details_block.dart';
import '../widget/pro_chat_appbar.dart';

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
                        projectId: widget.conversations.estimateBookingId,
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
