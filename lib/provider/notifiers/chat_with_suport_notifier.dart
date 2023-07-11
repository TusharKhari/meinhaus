import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_user_side/data/network/network_api_servcies.dart';
import 'package:new_user_side/data/pusher_services.dart';
import 'package:new_user_side/repository/chat_with_support_repository.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../data/models/pro_message_model.dart';
import '../../local/user_prefrences.dart';
import '../../res/common/my_snake_bar.dart';

class ChatWithSupportNotifier extends ChangeNotifier {
  PusherService _pusherService = PusherService();
  ChatWithSupportRepo repo = ChatWithSupportRepo();
  TextEditingController messageController = TextEditingController();
  final scrollController = ScrollController();

  // VARIABLES
  bool _loading = false;
  int _supportStatus = 0;
  String _ticketId = "";
  bool _loadMoreLoading = false;
  int _pageNo = 1;
  double _scrollPostion = 0;
  String _lastMessage = '';
  List<XFile> _images = [];
  XFile _image = XFile("");
  ProMessagesModel _supportMessages = ProMessagesModel();

  // GETTERS
  bool get loading => _loading;
  int get supportStatus => _supportStatus;
  String get ticketId => _ticketId;
  bool get loadMoreLoading => _loadMoreLoading;
  List<XFile> get images => _images;
  XFile get image => _image;
  ProMessagesModel get supportMessages => _supportMessages;

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

  setSupportStatus(int status) {
    _supportStatus = status;
    notifyListeners();
  }

  void setTicketId(String ticketId) {
    _ticketId = ticketId;
    notifyListeners();
  }

  void setMessages(ProMessagesModel messages) {
    _supportMessages = messages;
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
        _supportMessages.messages!.indexWhere((m) => m.id == messages.id);
    if (existingMessageIndex >= 0) {
      _supportMessages.messages![existingMessageIndex] = messages;
    } else {
      _supportMessages.messages!.add(messages);
    }
    notifyListeners();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (_supportMessages.messages!.isEmpty) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  /// Setup Pusher channel
  Future setupPusher(BuildContext context, String channelName) async {
    await _pusherService
        .setupPusherConnection(context, channelName)
        .then((value) {
      ("Pusher setup done").log("Pusher");
    }).onError((error, stackTrace) {
      showSnakeBarr(context, error.toString(), BarState.Error);
      ("Erorr in setup pusher --> $error").log("Pro-Chat Notifier");
    });
  }

  // Unsubscribe pusher channel
  void unsubscribe(String projectId) async {
    final userId = await UserPrefrences().getUserId();
    String channelName = "private-query.$projectId.$userId";
    _pusherService.pusher.unsubscribe(channelName: channelName);
    ("Channel Unsunscribed").log("Pusher");
  }

  /// Loads messages based on the provided `body` data.
  Future loadMessages(BuildContext context) async {
    setLoadingState(true, true);
    final ticketId = await UserPrefrences().getSupportTicketId();
    MapSS body = {"ticket_id": ticketId};
    await repo.loadMessages(body).then((response) {
      final data = ProMessagesModel.fromJson(response);
      setMessages(data);
      setPageNo(pageNo: 1);
      setLoadingState(false, true);
      _scrollToBottom();
    }).onError((error, stackTrace) {
      showSnakeBarr(context, error.toString(), BarState.Error);
      ("Erorr in Load Messages --> $error").log("Support-Chat Notifier");
      setLoadingState(false, true);
    });
  }
}


/// Listen for accept ticket event [ status, ticket_id]
/// Set status and ticket_id and notifiy
/// LoadMessage [ ticket-id] and set them in message model