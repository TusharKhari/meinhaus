import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:new_user_side/data/models/notifications_model.dart';
import 'package:new_user_side/repository/notification_repository.dart';
import 'package:new_user_side/utils/enum.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

class NotificationNotifier extends ChangeNotifier {
  final NotificationRepository repository = NotificationRepository();

  bool _isLoading = false;
  NetworkState _networkState = NetworkState.initial;
  NotificationsModel _notifications = NotificationsModel();

  bool get isLoading => _isLoading;
  NetworkState get networkState => _networkState;
  NotificationsModel get notifications => _notifications;

  void setLoading(bool state) {
    _isLoading = state;
    notifyListeners();
  }

  void setNetworkState(NetworkState newState) {
    _networkState = newState;
    notifyListeners();
  }

  void setNotifications(NotificationsModel notifications) {
    _notifications = notifications;
    notifyListeners();
  }

  Future getNotifications() async {
    setNetworkState(NetworkState.loading);
    setLoading(true);
    await repository.getNotification().then((response) {
      setNetworkState(NetworkState.data);
      final data = NotificationsModel.fromJson(response);
      setNotifications(data);
      setLoading(false);
    }).onError((error, stackTrace) {
      setNetworkState(NetworkState.error);
      setLoading(false);
      ("${error} $stackTrace").log("Notification notifier");
    });
  }
}
