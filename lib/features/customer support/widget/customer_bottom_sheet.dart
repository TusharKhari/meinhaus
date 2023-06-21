// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: height > 600 ? 85.h : 110.h,
      color: AppColors.white,
      child: Column(
        children: [
          const Divider(thickness: 1.0),
          10.vs,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Consumer<SupportUserMessagesProvider>(
              builder: (context, message, child) {
                return TextFormField(
                  controller: messageController,
                  onFieldSubmitted: (value) {
                    if (messageController.text.isNotEmpty) {
                      message.messageSend(
                        message: messageController.text,
                        context: context,
                      );
                      messageController.clear();
                    }
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: BorderSide(
                        color: AppColors.black.withOpacity(0.2),
                        width: 1.5.w,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide(
                        color: AppColors.black.withOpacity(0.15),
                        width: 1.5.w,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    hintText: "write a Meassage to check",
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.black.withOpacity(0.4),
                    ),
                    prefixIcon: widget.isSupportChat!
                        ? null
                        : Icon(
                            Icons.attach_file,
                            size: 20.sp,
                            color: AppColors.black,
                          ),
                    suffixIcon: widget.isSupportChat!
                        ? Row(
                            // mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.attach_file,
                                size: 20.sp,
                                color: AppColors.black,
                              ),
                              5.hs,
                              Icon(
                                Icons.send_sharp,
                                color: AppColors.buttonBlue,
                                size: 20.sp,
                              ),
                              20.hs,
                            ],
                          )
                        : Icon(
                            Icons.send_sharp,
                            color: AppColors.buttonBlue,
                            size: 20.sp,
                          ),
                  ),
                );
              },
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
