// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:new_user_side/provider/notifiers/chat_with_pro_notifier.dart';
import 'package:provider/provider.dart';

import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

class CustomerBottomSheet extends StatefulWidget {
  final bool? isSupportChat;
  const CustomerBottomSheet({
    Key? key,
    this.isSupportChat = false,
  }) : super(key: key);

  @override
  State<CustomerBottomSheet> createState() => _CustomerBottomSheetState();
}

class _CustomerBottomSheetState extends State<CustomerBottomSheet> {
  Future sendMessage() async {
    final notifier = context.read<ChatWithProNotifier>();
    if (notifier.messageController.text.isNotEmpty) {
      await notifier.sendMessage(context);
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
              onFieldSubmitted: (value) => sendMessage(),
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
                hintText: "write a Meassage to check",
                hintStyle: TextStyle(
                  fontSize: width / 28,
                  color: AppColors.black.withOpacity(0.4),
                ),
                prefixIcon: widget.isSupportChat!
                    ? null
                    : Icon(
                        Icons.attach_file,
                        size: width / 20,
                        color: AppColors.black,
                      ),
                suffixIcon: widget.isSupportChat!
                    ? Row(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.attach_file,
                            size: width / 20,
                            color: AppColors.black,
                          ),
                          SizedBox(width: width / 80),
                          Icon(
                            Icons.send_sharp,
                            color: AppColors.buttonBlue,
                            size: width / 20,
                          ),
                          SizedBox(width: width / 20),
                        ],
                      )
                    : InkWell(
                        onTap: () => sendMessage(),
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

class SupportUserMessagesProvider extends ChangeNotifier {
  bool _isSend = false;
  bool _isConversationEnds = false;
  List<Message> _messages = [];

  bool get isSend => _isSend;
  bool get isConversationEnds => _isConversationEnds;
  List<Message> get messagesList => _messages;
  void messageSend({
    required String message,
    required BuildContext context,
  }) {
    _isSend = true;
    final currentTime = TimeOfDay.now().format(context); // get the current time
    final newMessage = Message(text: message, time: currentTime);
    _messages.add(newMessage);
    notifyListeners();
  }

  void conversationEnd() {
    _isConversationEnds = true;
    notifyListeners();
  }
}

class Message {
  final String text;
  final String time;

  Message({
    required this.text,
    required this.time,
  });
}
