import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherTest extends StatefulWidget {
  const PusherTest({Key? key}) : super(key: key);

  @override
  State<PusherTest> createState() => _PusherTestState();
}

class _PusherTestState extends State<PusherTest> {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  String _log = 'output:\n';
  final apiKey = "823f246fdf95c1ff3f95";
  final cluster = "ap2";
  final channelName = "private-chat.2";
  final toChannelName = "private-chat.4";
  final String eventName = "message-sent";
  String token = "85|yZZhVY7zvwPG743n0alVzUncZ9hYDSXz4aGdCbt9";
  final _eventFormKey = GlobalKey<FormState>();
  final _listViewController = ScrollController();
  final _data = TextEditingController();

  void log(String text) {
    print("LOG: $text");
    setState(
      () {
        _log += text + "\n";
        Timer(
          const Duration(milliseconds: 100),
          () {
            _listViewController
                .jumpTo(_listViewController.position.maxScrollExtent);
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    onConnectPressed();
  }

  void onConnectPressed() async {
    // Remove keyboard
    // FocusScope.of(context).requestFocus(FocusNode());
    try {
      await pusher.init(
        apiKey: apiKey,
        cluster: cluster,
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
        onSubscriptionCount: onSubscriptionCount,
        //authEndpoint: "https://meinhaus.ca/broadcasting/auth",
        onAuthorizer: onAuthorizer,
      );
      await pusher.subscribe(channelName: channelName);
      await pusher.connect();
    } catch (e) {
      log("ERROR: $e");
    }
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    log("Connection: $currentState");
  }

  void onError(String message, int? code, dynamic e) {
    log("onError: $message code: $code exception: $e");
  }

  void onEvent(PusherEvent event) {
    ("New Event").log();
    log("onEvent: $event");
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    log("onSubscriptionSucceeded: $channelName data: $data");
    final me = pusher.getChannel(channelName)?.me;
    log("Me: $me");
  }

  void onSubscriptionError(String message, dynamic e) {
    log("onSubscriptionError: $message Exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    log("onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    log("onMemberAdded: $channelName user: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    log("onMemberRemoved: $channelName user: $member");
  }

  void onSubscriptionCount(String channelName, int subscriptionCount) {
    log("onSubscriptionCount: $channelName subscriptionCount: $subscriptionCount");
  }

  dynamic onAuthorizer(
      String channelName, String socketId, dynamic options) async {
    print(options);
    var authUrl = "https://meinhaus.ca/broadcasting/auth";
    var result = await http.post(
      Uri.parse(authUrl),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer ${token}',
      },
      body: 'socket_id=' + socketId + '&channel_name=' + channelName + '',
    );
    var json = jsonDecode(result.body);
    print(json);
    print(json['auth']);
    return {
      "auth": json['auth'],
      //"channel_data": {"user_id": 2},
      "shared_secret": json["shared_secret"],
    };
  }

  void onTriggerEventPressed() async {
    if (_eventFormKey.currentState!.validate()) {
      
      await pusher.trigger(
        PusherEvent(
          channelName: "private-chat.2",
          eventName: eventName,
          data: _data.text,
        ),
      );
      print("Event triggerd");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            pusher.connectionState == 'DISCONNECTED'
                ? 'Pusher Channels Example'
                : channelName,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            controller: _listViewController,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: <Widget>[
              if (pusher.connectionState != 'CONNECTED')
                ElevatedButton(
                  onPressed: onConnectPressed,
                  child: const Text('Connect'),
                )
              else
                Form(
                  key: _eventFormKey,
                  child: Column(
                    children: <Widget>[
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: pusher.channels[channelName]?.members.length,
                        itemBuilder: (context, index) {
                          final member = pusher
                              .channels[channelName]!.members.values
                              .elementAt(index);

                          return ListTile(
                              title: Text(member.userInfo.toString()),
                              subtitle: Text(member.userId));
                        },
                      ),
                      TextFormField(
                        controller: _data,
                        decoration: const InputDecoration(
                          labelText: 'Data',
                        ),
                      ),
                      ElevatedButton(
                        onPressed: onTriggerEventPressed,
                        child: const Text('Trigger Event'),
                      ),
                    ],
                  ),
                ),
              SingleChildScrollView(child: Text(_log)),
            ],
          ),
        ),
      ),
    );
  }
}
