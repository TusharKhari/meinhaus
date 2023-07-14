import 'package:flutter/material.dart';
import 'package:new_user_side/data/network/network_api_servcies.dart';
import 'package:new_user_side/data/pusher_services.dart';
import 'package:new_user_side/features/home/screens/home_screen.dart';
import 'package:new_user_side/provider/notifiers/chat_notifier.dart';
import 'package:new_user_side/provider/notifiers/estimate_notifier.dart';
import 'package:new_user_side/repository/customer_support_repo.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../data/models/message_model.dart';
import '../../local/user_prefrences.dart';
import '../../res/common/my_snake_bar.dart';

class SupportNotifier extends ChangeNotifier {
  PusherService _pusherService = PusherService();
  TextEditingController messageController = TextEditingController();
  CustomerSupportRepo repo = CustomerSupportRepo();

  // VARIABLES
  bool _loading = false;
  int _supportStatus = 0;
  String _ticketId = "";
  bool _showClosingDialog = false;
  List _pusherChannels = [];


  // GETTERS
  bool get loading => _loading;
  int get supportStatus => _supportStatus;
  String get ticketId => _ticketId;
  bool get showClosingDialog => _showClosingDialog;

  void setLoadingState(bool state, bool notify) {
    _loading = state;
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

  void setShowClosingDialog(bool status) {
    _showClosingDialog = status;
    notifyListeners();
  }

  void setTicketId(String ticketId) {
    _ticketId = ticketId;
    notifyListeners();
  }

  /// Setup Pusher channel
  Future setupPusher(BuildContext context, List channelNames) async {
    await _pusherService
        .setupPusherConnection(context, channelNames)
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
    ("Channel Unsunscribed $channelName").log("Pusher");
  }

  // Keep open support chat
  Future keepOpen(BuildContext context) async {
    final chatNotifier = context.read<ChatNotifier>();
    final project = context.read<EstimateNotifier>().projectDetails;
    final conversationId = chatNotifier.myMessaage.conversationId;
    final ticketId = project.services!.query!.ticket!;
    MapSS body = {
      "conversation_id": conversationId.toString(),
      "ticket_id": ticketId,
      "message": messageController.text,
    };
    setLoadingState(true, true);
    await repo.sendQuery(body).then((response) {
      setLoadingState(false, true);
      final data = MessageModel.fromJson(response);
      for (var message in data.messages!) {
        chatNotifier.updateOrAddNewMessage(message);
      }
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      showSnakeBarr(context, error.toString(), BarState.Error);
      ("Erorr in keep open --> $error").log("Support Notifier");
      setLoadingState(false, true);
    });
  }

  // Accept and close support chat
  Future acceptAndClose(BuildContext context) async {
    final chatNotifier = context.read<ChatNotifier>();
    final project = context.read<EstimateNotifier>().projectDetails;
    final conversationId = chatNotifier.myMessaage.conversationId;
    final ticketId = project.services!.query!.ticket!;
    MapSS body = {
      "conversation_id": conversationId.toString(),
      "ticket_id": ticketId,
    };
    setLoadingState(true, true);
    await repo.acceptAndClose(body).then((response) {
      setLoadingState(false, true);
      Navigator.of(context).pushScreen(HomeScreen());
    }).onError((error, stackTrace) {
      showSnakeBarr(context, error.toString(), BarState.Error);
      ("Erorr in accept and close --> $error").log("Support Notifier");
      setLoadingState(false, true);
    });
  }
}
