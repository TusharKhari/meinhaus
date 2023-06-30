import 'package:flutter/material.dart';

class ChatWithProNotifier extends ChangeNotifier {
  TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  

}


/*
Step 1 get Conversation list
Step 2 get conversation related to user
Step 3 listen to events and add them to message list
Step 4 trigger an event and add them to message list
*/