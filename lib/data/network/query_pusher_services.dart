import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_user_side/local/user_prefrences.dart';
import 'package:new_user_side/provider/notifiers/support_notifier.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class QueryPusherService {
  final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  final apiKey = "823f246fdf95c1ff3f95";
  final cluster = "ap2";

  Future<void> setupPusherConnection(
    BuildContext context,
    String channelName,
  ) async {
    try {
      await pusher.init(
        apiKey: apiKey,
        cluster: cluster,
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: (event) => onEvent(event, context),
        onSubscriptionError: onSubscriptionError,
        onSubscriptionCount: onSubscriptionCount,
        onAuthorizer: onAuthorizer,
      );
      await pusher.subscribe(channelName: channelName);
      await pusher.connect();
    } catch (e) {
      print("ERROR: $e");
    }
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    print("Connection: $currentState");
  }

  void onError(String message, int? code, dynamic e) {
    print("onError: $message code: $code exception: $e");
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    print("onSubscriptionSucceeded: $channelName data: $data");
    final me = pusher.getChannel(channelName)?.me;
    print("Me: $me");
  }

  void onSubscriptionError(String message, dynamic e) {
    print("onSubscriptionError: $message Exception: $e");
  }
  
  void onSubscriptionCount(String channelName, int subscriptionCount) {
    print(
        "onSubscriptionCount: $channelName subscriptionCount: $subscriptionCount");
  }

  Future<dynamic> onAuthorizer(
    String channelName,
    String socketId,
    dynamic options,
  ) async {
    try {
      final token = await UserPrefrences().getToken();
      var result = await http.post(
        Uri.parse("https://meinhaus.ca/broadcasting/auth"),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer $token',
        },
        body: 'socket_id=' + socketId + '&channel_name=' + channelName + '',
      );
      var json = jsonDecode(result.body);
      print(json['auth']);
      return {"auth": json['auth']};
    } catch (err) {
      (err).log("Pusher onAuth error");
    }
  }

  void onEvent(PusherEvent event, BuildContext context) async {
    try {
      final notifier = context.read<SupportNotifier>();
      final data = json.decode(event.data as String) as Map<String, dynamic>;
      if (event.eventName == "ticket-accepted") {
        await notifier.setSupportStatus(1);
      } else if (event.eventName == "ticket-close-request") {
        notifier.setShowClosingDialog(true);
      } else if (event.eventName == "ticket-flagged") {}
    } catch (err) {
      (err).log("OnSupportEvent Error");
    }
    print("onSupportEvent: $event");
  }
}
