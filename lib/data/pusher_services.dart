import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_user_side/data/models/pro_message_model.dart';
import 'package:new_user_side/provider/notifiers/auth_notifier.dart';
import 'package:new_user_side/provider/notifiers/chat_with_pro_notifier.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import 'network/network_api_servcies.dart';

class PusherService {
  final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  final apiKey = "823f246fdf95c1ff3f95";
  final cluster = "ap2";

  Future<void> setupPusherConnection(BuildContext context) async {
    try {
      final userNotifier = context.read<AuthNotifier>().user;
      final userId = userNotifier.userId.toString();
      await pusher.init(
        apiKey: apiKey,
        cluster: cluster,
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: (event) => onEvent(event, context),
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
        onSubscriptionCount: onSubscriptionCount,
        onAuthorizer: onAuthorizer,
      );
      await pusher.subscribe(channelName: "private-chat.$userId");
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

  void onEvent(PusherEvent event, BuildContext context) {
    try {
      final notifier = context.read<ChatWithProNotifier>();
      final data = json.decode(event.data as String) as Map<String, dynamic>;

      if (event.eventName == "message-sent") {
        // Handle "message-sent" event
        final body = {
          "conversation_id": data["conversation_id"].toString(),
          "to_user_id": data["message_data"]["sender_id"].toString(),
          "message_id": data["message_data"]["id"].toString(),
        };
        notifier.readMessage(body);
        final message = Messages.fromJson(data['message_data']);
        notifier.updateOrAddNewMessage(message);
      } else if (event.eventName == "message-read") {
        // Handle "message-read" event
        final messages = notifier.proMessages.messages!;
        final updatedMessages = messages.map(
          (message) {
            if (message.senderId == 2) {
              return message.copyWith(isSeen: 2);
            }
            return message;
          },
        ).toList();
        notifier.setMessages(
            notifier.proMessages.copyWith(messages: updatedMessages));
      }
    } catch (e) {
      (e).log("OnEvent Error");
    }
    print("onEvent: $event");
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    print("onSubscriptionSucceeded: $channelName data: $data");
    final me = pusher.getChannel(channelName)?.me;
    print("Me: $me");
  }

  void onSubscriptionError(String message, dynamic e) {
    print("onSubscriptionError: $message Exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    print("onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    print("onMemberAdded: $channelName user: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    print("onMemberRemoved: $channelName user: $member");
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
    print(channelName);
    print(socketId);
    var result = await http.post(
      Uri.parse("https://meinhaus.ca/broadcasting/auth"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer 93|h423P8Hi3tuYxx1m9eLzPpEl7PX92NskBcsQyTy7',
      },
      body: 'socket_id=' + socketId + '&channel_name=' + channelName + '',
    );
    var json = jsonDecode(result.body);
    print(json['auth']);
    return {"auth": json['auth']};
  }
}
