import 'package:flutter/material.dart';
import 'package:new_user_side/data/models/conversation_list_model.dart';
import 'package:new_user_side/data/models/pro_message_model.dart';
import 'package:new_user_side/data/network/network_api_servcies.dart';
import 'package:new_user_side/repository/chat_with_pro_repository.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../res/common/my_snake_bar.dart';

class ChatWithProNotifier extends ChangeNotifier {
  ChatWithProRepo repo = ChatWithProRepo();
  TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  // VARIABLES
  bool _loading = false;
  ConversationsListModal _conversationsList = ConversationsListModal();
  ProMessagesModel _proMessages = ProMessagesModel();

  // GETTERS
  bool get loading => _loading;
  ConversationsListModal get conversationsList => _conversationsList;
  ProMessagesModel get proMessages => _proMessages;

  // SETTERS
  void setLoadingState(bool state, bool notify) {
    _loading = state;
    if (notify) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  void setAllConversationList(ConversationsListModal conversationsList) {
    _conversationsList = conversationsList;
    notifyListeners();
  }

  void setMessages(ProMessagesModel messages) {
    _proMessages = messages;
    notifyListeners();
  }

  // METHODS
  /// Fetches all conversations list based on the provided `body` data.
  Future allConversation(BuildContext context) async {
    setLoadingState(true, true);
    await repo.allConversation().then((response) {
      showSnakeBarr(context, "All conversation loaded", BarState.Success);
      final data = ConversationsListModal.fromJson(response);
      setAllConversationList(data);
      setLoadingState(false, true);
    }).onError((error, stackTrace) {
      showSnakeBarr(context, error.toString(), BarState.Error);
      ("Erorr in All Conversation --> $error").log("Pro-Chat Notifier");
      setLoadingState(false, true);
    });
  }

  /// Loads messages based on the provided `body` data.
  Future loadMessages({
    required BuildContext context,
    required MapSS body,
  }) async {
    setLoadingState(true, true);
    await repo.loadMessages(body).then((response) {
      print(response);
      final data = ProMessagesModel.fromJson(response);
      setMessages(data);
      setLoadingState(false, true);
    }).onError((error, stackTrace) {
      showSnakeBarr(context, error.toString(), BarState.Error);
      ("Erorr in Load Messages --> $error").log("Pro-Chat Notifier");
      setLoadingState(false, true);
    });
  }
}


/*
Step 1 get Conversation list
Step 2 get conversation related to user
Step 3 listen to events and add them to message list
Step 4 trigger an event and add them to message list
*/