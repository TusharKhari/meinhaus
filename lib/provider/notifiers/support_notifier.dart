import 'package:flutter/material.dart';
import 'package:new_user_side/data/pusher_services.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../local/user_prefrences.dart';
import '../../res/common/my_snake_bar.dart';

class SupportNotifier extends ChangeNotifier {
  PusherService _pusherService = PusherService();

  // VARIABLES
  bool _loading = false;
  int _supportStatus = 0;
  String _ticketId = "";

  // GETTERS
  bool get loading => _loading;
  int get supportStatus => _supportStatus;
  String get ticketId => _ticketId;

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

  void setTicketId(String ticketId) {
    _ticketId = ticketId;
    notifyListeners();
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
    ("Channel Unsunscribed $channelName").log("Pusher");
  }
}
