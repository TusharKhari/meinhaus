import 'package:flutter/material.dart';
import 'package:new_user_side/data/models/conversation_list_model.dart';
import 'package:new_user_side/data/models/pro_message_model.dart';
import 'package:new_user_side/data/network/network_api_servcies.dart';
import 'package:new_user_side/data/pusher_services.dart';
import 'package:new_user_side/repository/chat_with_pro_repository.dart';
import 'package:new_user_side/utils/enum.dart';
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
    messageController.dispose();
    scrollController.dispose();
    _proMessages.messages!.clear();
    super.dispose();
  }

  // VARIABLES
  bool _loading = false;
  int _pageNo = 1;
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

  void setPageNo({int? pageNo}) {
    if (pageNo != null) {
      _pageNo = pageNo;
    } else {
      _pageNo++;
    }
    notifyListeners();
  }

  void updateOrAddNewMessage(Messages messages) {
    final existingMessageIndex =
        _proMessages.messages!.indexWhere((m) => m.id == messages.id);
    if (existingMessageIndex >= 0) {
      print("same message");
      _proMessages.messages![existingMessageIndex] = messages;
    } else {
      print("different");
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
      _scrollToBottom();
      setPageNo(pageNo: 1);
      setLoadingState(false, true);
    }).onError((error, stackTrace) {
      showSnakeBarr(context, error.toString(), BarState.Error);
      ("Erorr in Load Messages --> $error").log("Pro-Chat Notifier");
      setLoadingState(false, true);
    });
  }

  /// Setup Pusher channel
  Future setupPusher(BuildContext context, MapSS body) async {
    await _pusherService.setupPusherConnection(context).then((value) {
      loadMessages(context: context, body: body);
      ("Pusher setup done").log("Pusher");
    }).onError((error, stackTrace) {
      showSnakeBarr(context, error.toString(), BarState.Error);
      ("Erorr in setup pusher --> $error").log("Pro-Chat Notifier");
    });
  }

  Future sendMessage(BuildContext context) async {
    sendDummyMessage(context);
    MapSS body = {
      "message": messageController.text,
      "conversation_id": _proMessages.conversationId.toString(),
    };
    await repo.sendMessage(body).then(
      (response) {
        final data = ProMessagesModel.fromJson(response);
        // if user send multiple message
        for (var message in data.messages!) {
          updateOrAddNewMessage(message);
        }
        messageController.clear();
      },
    ).onError((error, stackTrace) {
      showSnakeBarr(context, error.toString(), BarState.Error);
      ("Erorr in Send Message --> $error").log("Pro-Chat Notifier");
      messageController.clear();
    });
  }

  sendDummyMessage(BuildContext context) {
    // Add a new message
    final userNotifier = context.read<AuthNotifier>().user;
    final userId = userNotifier.userId;
    final messageId = proMessages.messages!.last.id;
    final message = Messages(
      id: messageId! + 1,
      senderId: userId,
      isSeen: 0,
      forwarded: 0,
      message: messageController.text,
      createdAt: DateTime.now().toString(),
      type: "text",
    );
    updateOrAddNewMessage(message);
  }

  Future loadMoreMessages(BuildContext context) async {
    MapSS body = {
      "conversation_id": _proMessages.conversationId.toString(),
      "paginateVar": _pageNo.toString(),
    };
    if (_proMessages.messageCount != _proMessages.messages!.length) {
      await repo.loadMoreMessages(body).then((response) {
        final data = ProMessagesModel.fromJson(response);
        _proMessages.messages!.insertAll(0, data.messages!);
        setPageNo();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollController.jumpTo(scrollController.position.extentBefore);
        });
      }).onError((error, stackTrace) {
        showSnakeBarr(context, error.toString(), BarState.Error);
        ("Erorr in Load More Message --> $error").log("Pro-Chat Notifier");
      });
    } else {
      showSnakeBarr(context, "No more messages to load", BarState.Info);
    }
  }

  Future readMessage(MapSS body) async {
    repo.readMessage(body).then((value) {
      print("messages readed by sender");
    }).onError((error, stackTrace) {
      ("Erorr in Read Message --> $error").log("Pro-Chat Notifier");
    });
  }
}

/// Send events using api calling [Done]
/// Add those messages to pro message list [Done]
/// show is seen or not [not getting message data on message-read]
/// load more messages
/// show the dates block of messages like whatsapp
/// -------------------------------------------------
/// send files also
/// download pdfs/show pictures send by pro
