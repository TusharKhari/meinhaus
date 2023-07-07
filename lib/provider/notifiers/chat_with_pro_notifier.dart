import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_user_side/data/models/conversation_list_model.dart';
import 'package:new_user_side/data/models/pro_message_model.dart';
import 'package:new_user_side/data/network/network_api_servcies.dart';
import 'package:new_user_side/data/pusher_services.dart';
import 'package:new_user_side/local/user_prefrences.dart';
import 'package:new_user_side/repository/chat_with_pro_repository.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/utils.dart';
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
  bool _loadMoreLoading = false;
  int _pageNo = 1;
  double _scrollPostion = 0;
  String _lastMessage = '';
  List<XFile> _images = [];
  XFile _image = XFile("");
  ConversationsListModal _conversationsList = ConversationsListModal();
  ProMessagesModel _proMessages = ProMessagesModel();

  // GETTERS
  bool get loading => _loading;
  bool get loadMoreLoading => _loadMoreLoading;
  List<XFile> get images => _images;
  XFile get image => _image;
  ConversationsListModal get conversationsList => _conversationsList;
  ProMessagesModel get proMessages => _proMessages;

  void setLoadingState(bool state, bool notify) {
    _loading = state;
    if (notify) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  void setLoadMoreLoading(bool state, bool notify) {
    _loadMoreLoading = state;
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

  void setImagesInList(List<XFile> images) {
    _images = images;
    notifyListeners();
  }

  void setImage(XFile image) {
    _image = image;
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

  void setScrollPostion(double newPosition) {
    _scrollPostion = newPosition;
    notifyListeners();
  }

  void setLastMessage(String text) {
    _lastMessage = text;
    notifyListeners();
  }

  void _scrollToBottom() {
    if (_proMessages.messages!.isEmpty) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  void _loadMoreScroll() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent - _scrollPostion,
        duration: Duration(milliseconds: 600),
        curve: Curves.ease,
      );
    });
  }

  void updateOrAddNewMessage(Messages messages) {
    final existingMessageIndex =
        _proMessages.messages!.indexWhere((m) => m.id == messages.id);
    if (existingMessageIndex >= 0) {
      _proMessages.messages![existingMessageIndex] = messages;
    } else {
      _proMessages.messages!.add(messages);
    }
    notifyListeners();
    _scrollToBottom();
  }

  void unsubscribe() async {
    final userId = await UserPrefrences().getUserId();
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
      setPageNo(pageNo: 1);
      setLoadingState(false, true);
      _scrollToBottom();
    }).onError((error, stackTrace) {
      showSnakeBarr(context, error.toString(), BarState.Error);
      ("Erorr in Load Messages --> $error").log("Pro-Chat Notifier");
      setLoadingState(false, true);
    });
  }

  /// Setup Pusher channel
  Future setupPusher(BuildContext context) async {
    await _pusherService.setupPusherConnection(context).then((value) {
      ("Pusher setup done").log("Pusher");
    }).onError((error, stackTrace) {
      showSnakeBarr(context, error.toString(), BarState.Error);
      ("Erorr in setup pusher --> $error").log("Pro-Chat Notifier");
    });
  }

  /// Send Messages [ Texts/Images/Pdf's ]
  Future sendMessage({required BuildContext context}) async {
    if (image.path.isEmpty) {
      sendDummyMessage(context);
    } else {
      setLastMessage("");
    }
    // getting img if there is any
    final imgPath = await Utils.convertToMultipartFile(image);
    // setting up body
    Map<String, dynamic> body = {
      "message": _lastMessage,
      "conversation_id": _proMessages.conversationId.toString(),
      "files[]": imgPath,
    };
    // calling api
    await repo.sendMessage(body).then((response) {
      final data = ProMessagesModel.fromJson(response);
      for (var message in data.messages!) {
        updateOrAddNewMessage(message);
      }
      setImage(XFile(""));
    }).onError((error, stackTrace) {
      showSnakeBarr(context, error.toString(), BarState.Error);
      ("Erorr in Send Message --> $error $stackTrace").log("Pro-Chat Notifier");
    });
  }

  /// Send Dummy Message Before calling the api and getting the response
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
    setLastMessage(messageController.text);
    messageController.clear();
  }

  /// Load 20 more messages every time we hit this api
  Future loadMoreMessages(BuildContext context) async {
    setLoadMoreLoading(true, true);
    MapSS body = {
      "conversation_id": _proMessages.conversationId.toString(),
      "paginateVar": _pageNo.toString(),
    };
    if (_proMessages.messageCount != _proMessages.messages!.length) {
      await repo.loadMoreMessages(body).then((response) {
        final data = ProMessagesModel.fromJson(response);
        _proMessages.messages!.insertAll(0, data.messages!);
        setPageNo();
        setScrollPostion(scrollController.position.maxScrollExtent);
        _loadMoreScroll();
        setLoadMoreLoading(false, true);
      }).onError((error, stackTrace) {
        setLoadMoreLoading(false, true);
        showSnakeBarr(context, error.toString(), BarState.Error);
        ("Erorr in Load More Message --> $error").log("Pro-Chat Notifier");
      });
    } else {
      showSnakeBarr(context, "No more messages to load", BarState.Info);
    }
  }

  /// Read messages
  Future readMessage(MapSS body) async {
    if (proMessages.messages!.isNotEmpty)
      repo.readMessage(body).then((value) {
        print("messages readed by sender");
      }).onError((error, stackTrace) {
        ("Erorr in Read Message --> $error").log("Pro-Chat Notifier");
      });
  }
}

/// Send events using api calling [Done]
/// Add those messages to pro message list [Done]
/// show is seen or not [Done]
/// load more messages  [Done]
/// show the dates block of messages like whatsapp
/// -------------------------------------------------
/// send files also [Done Imgs]
/// download pdfs/show pictures send by pro []
