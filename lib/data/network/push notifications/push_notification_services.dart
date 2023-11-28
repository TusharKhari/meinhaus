import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:new_user_side/features/notification/screens/notification_screen.dart';
import 'package:new_user_side/main.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../utils/constants/constant.dart';

// This function help us to handle all the notifications when app was running in background
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("Title : ${message.notification!.title}");
  print("Body : ${message.notification!.body}");
  print("Payload : ${message.data}");
}

class PushNotificationServices {
  // Getting the instamce of firebaseMessage
  final _firebaseMessaging = FirebaseMessaging.instance;

  // Setup Android channel
  final _androidChannel = const AndroidNotificationChannel(
    "pushnotificationapp", // id
    "pushnotificationappchannel", // name
    description: "This channel is used for important notifications",
    importance: Importance.max,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  // Handling all the messages coming from firebase
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
    _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    // When app is opend for terminated state
    _firebaseMessaging.getInitialMessage().then((handleMessage));
    // Execute [ handleMessage ] function when app is running in background
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    // When app is running in background we will print all the notification
    // details on cosole [ title, name, id, etc..]
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

  // Initializing notifications
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
   if(isTest)  ("$fCMToken").log("FCM Token");
    initPushNotifications();
    initLocalNotifications();
  }
}
