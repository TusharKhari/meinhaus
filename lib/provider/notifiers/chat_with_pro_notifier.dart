import 'package:flutter/material.dart';
import 'package:new_user_side/data/models/conversation_list_model.dart';
import 'package:new_user_side/data/models/pro_message_model.dart';
import 'package:new_user_side/data/network/network_api_servcies.dart';
import 'package:new_user_side/data/pusher_services.dart';
import 'package:new_user_side/repository/chat_with_pro_repository.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../res/common/my_snake_bar.dart';
import 'auth_notifier.dart';

class ChatWithProNotifier extends ChangeNotifier {
  ChatWithProRepo repo = ChatWithProRepo();
  PusherService _pusherService = PusherService();
  TextEditingController messageController = TextEditingController();
  final scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
    scrollController.dispose();
    _proMessages.messages!.clear();
    _pusherService.pusher.disconnect();
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

  void _scrollToBottom() {
    if (_proMessages.messages!.isEmpty) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  void setAllConversationList(ConversationsListModal conversationsList) {
    _conversationsList = conversationsList;
    notifyListeners();
  }

  void setMessages(ProMessagesModel messages) {
    _proMessages = messages;
    notifyListeners();
  }

  void updateOrAddNewMessage(Messages messages) {
    final index = _proMessages.messages!.indexOf(messages);
    if (index >= 0) {
      _proMessages.messages![index] = messages;
    } else {
      _proMessages.messages!.add(messages);
    }
    notifyListeners();
    _scrollToBottom();
  }

  void unsubscribe(BuildContext context) {
    final userNotifier = context.read<AuthNotifier>().user;
    final userId = userNotifier.userId.toString();
    String channelName = "private-chat.$userId";
    _pusherService.pusher.unsubscribe(channelName: channelName);
    ("Channel Unsunscribed").log("Pusher");
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

  /// Loads messages based on the provided `body` data.
  Future loadMessages({
    required BuildContext context,
    required MapSS body,
  }) async {
    setLoadingState(true, true);
    await repo.loadMessages(body).then((response) {
      final data = ProMessagesModel.fromJson(response);
      setMessages(data);
      setLoadingState(false, true);
    }).onError((error, stackTrace) {
      showSnakeBarr(context, error.toString(), BarState.Error);
      ("Erorr in Load Messages --> $error").log("Pro-Chat Notifier");
      setLoadingState(false, true);
    });
  }

  /// Setup Pusher channel
  Future setupPusher(
    BuildContext context,
    MapSS body,
  ) async {
    await _pusherService.setupPusherConnection(context).then((value) {
      ("Pusher setup done").log("Pusher");
      loadMessages(context: context, body: body);
      _scrollToBottom();
    }).onError((error, stackTrace) {
      showSnakeBarr(context, error.toString(), BarState.Error);
      ("Erorr in setup pusher --> $error").log("Pro-Chat Notifier");
    });
  }
}

