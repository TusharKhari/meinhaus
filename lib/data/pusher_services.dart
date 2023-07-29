import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_user_side/data/models/message_model.dart';
import 'package:new_user_side/local/user_prefrences.dart';
import 'package:new_user_side/provider/notifiers/auth_notifier.dart';
import 'package:new_user_side/provider/notifiers/chat_notifier.dart';
import 'package:new_user_side/provider/notifiers/chat_with_pro_notifier.dart';
import 'package:new_user_side/provider/notifiers/support_notifier.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../static componets/dialogs/customer_close_ticket_dialog.dart';

class PusherService {
  final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  final apiKey = "823f246fdf95c1ff3f95";
  final cluster = "ap2";

  // List of all the channelsName
  List _channelName = [];

  List get channelName => _channelName;

  // Add new channels in exting channelNames List
  Future<void> addChannel(String channelName) async {
    if (!_channelName.contains(channelName)) {
      _channelName.add(channelName);
    }
  }

  // Remove  channel in exting channelNames List
  Future<void> removeChannel(String channelName) async {
    if (_channelName.contains(channelName)) {
      _channelName.remove(channelName);
    }
  }

  Future<void> setupPusherConnection(
    BuildContext context,
    List channelNames,
  ) async {
    try {
      await pusher.init(
        apiKey: apiKey,
        cluster: cluster,
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: (event) => onChatEvent(event, context),
        onSubscriptionError: onSubscriptionError,
        onSubscriptionCount: onSubscriptionCount,
        onAuthorizer: onAuthorizer,
      );
      // await pusher.subscribe(channelName: channelName);
      await pusher.connect();
      for (final channelName in channelNames) {
        await pusher.subscribe(channelName: channelName);
      }
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
    // final me = pusher.getChannel(channelName)?.me;
    // print("Me: $me");
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
        Uri.parse("https://meinhaus.ca/meinhaus/broadcasting/auth"),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer $token',
        },
        body: 'socket_id=' + socketId + '&channel_name=' + channelName + '',
      );
      var json = jsonDecode(result.body);
      return {"auth": json['auth']};
    } catch (err) {
      (err).log("Pusher onAuth error");
    }
  }

  void onChatEvent(PusherEvent event, BuildContext context) async {
    try {
      final notifier = context.read<ChatNotifier>();
      final proChatNotifier = context.read<ChatWithProNotifier>();
      final supportNotifier = context.read<SupportNotifier>();
      final userNotifier = context.read<AuthNotifier>().user;
      final data = json.decode(event.data as String) as Map<String, dynamic>;
      // Handle "message-sent" event
      if (event.eventName == "message-sent") {
        final body = {
          "conversation_id": data["conversation_id"].toString(),
          "to_user_id": data["message_data"]["sender_id"].toString(),
          "message_id": data["message_data"]["id"].toString(),
        };
        notifier.readMessage(body);
        proChatNotifier.allConversation(context);
        if (notifier.myMessaage.messages!.isNotEmpty) {
          final message = Messages.fromJson(data['message_data']);
          notifier.updateOrAddNewMessage(message);
        }
      }
      // Handle "message-read" event
      else if (event.eventName == "message-read") {
        final messages = notifier.myMessaage.messages!;
        final updatedMessages = messages.map(
          (message) {
            if (message.senderId == userNotifier.userId) {
              return message.copyWith(isSeen: 2);
            }
            return message;
          },
        ).toList();
        notifier.setMessages(
          notifier.myMessaage.copyWith(messages: updatedMessages),
        );
      }
      // Handle "ticket-accepted" evetns
      else if (event.eventName == "ticket-accepted") {
        await supportNotifier.setSupportStatus(1);
        await supportNotifier.setTicketId(data['ticket_id']);
      }
      // Handle "ticket-close-request" evetns
      else if (event.eventName == "ticket-close-request") {
        supportNotifier.setShowClosingDialog(true);
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const CustosmerCloseTicketDialog();
          },
        );
      }
      // Handle "ticket-flagged" evetns
      else if (event.eventName == "ticket-flagged") {
        supportNotifier.setIsQueryFlagged(true);
      }
    } catch (e) {
      (e).log("OnEvent Error");
    }
    print("onEvent: $event");
  }
}
