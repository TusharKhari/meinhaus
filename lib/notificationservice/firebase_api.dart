import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:new_user_side/features/notification/screens/notification_scree.dart';
import 'package:new_user_side/main.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("Title : ${message.notification!.title}");
  print("Body : ${message.notification!.body}");
  print("Payload : ${message.data}");
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    "pushnotificationapp",
    "pushnotificationappchannel",
    description: "This channel is used for important notifications",
    importance: Importance.max,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    navigatorKey.currentState!.pushScreen(NotificationScreen());
  }

  Future initLocalNotifications() async {
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/home');
    const settings = InitializationSettings(android: android, iOS: iOS);
    await _localNotifications.initialize(
      settings,
      // onDidReceiveNotificationResponse: (payload) {
      //   final message = RemoteMessage.fromMap(jsonDecode(payload.payload!));
      //   handleMessage(message);
      // },
      // onDidReceiveBackgroundNotificationResponse: (payload) {
      //   final message = RemoteMessage.fromMap(jsonDecode(payload.toString()));
      //   handleMessage(message);
      // },
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform!.createNotificationChannel(_androidChannel);
  }

// Very important for ios foreground notifications
  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    // When app is opend for terminated state
    FirebaseMessaging.instance.getInitialMessage().then((handleMessage));
    // Execute [ handleMessage ] function when app is running in background
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen(
      (message) {
        final notification = message.notification;
        if (notification == null) return;

        _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: "@drawable/home",
            ),
          ),
          payload: jsonEncode(message.toMap()),
        );
      },
    );
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print("Token : $fCMToken");
    initPushNotifications();
    initLocalNotifications();
  }
}
