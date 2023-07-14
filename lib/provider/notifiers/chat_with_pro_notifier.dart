import 'package:flutter/material.dart';
import 'package:new_user_side/data/models/conversation_list_model.dart';
import 'package:new_user_side/repository/chat_respository.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../res/common/my_snake_bar.dart';

class ChatWithProNotifier extends ChangeNotifier {
  ChatRepository repo = ChatRepository();

  // VARIABLES
  bool _loading = false;
  ConversationsListModal _conversationsList = ConversationsListModal();

  // GETTERS
  bool get loading => _loading;
  ConversationsListModal get conversationsList => _conversationsList;

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

  // METHODS
  /// Fetches all conversations list based on the provided `body` data.
  Future allConversation(BuildContext context) async {
    setLoadingState(true, true);
    await repo.allConversation().then((response) {
      final data = ConversationsListModal.fromJson(response);
      setAllConversationList(data);
      setLoadingState(false, true);
    }).onError((error, stackTrace) {
      showSnakeBarr(context, error.toString(), BarState.Error);
      ("Erorr in All Conversation --> $error").log("Pro-Chat Notifier");
      setLoadingState(false, true);
    });
  }
}
