import 'package:flutter_test/flutter_test.dart';
import 'package:new_user_side/data/models/notifications_model.dart';

final mokedNotification = NotificationsModel(
  success: true,
  notifications: mockedNotifications,
);
final mockedNotifications = [
  Notifications(
    id: "03235a7c-8dbe-4d9a-8e8d-7c468096ce36",
    userId: 2,
    type: "",
    icon: "",
    message: "New payment request.",
    url: "http://127.0.0.1:8000/estimate_booking/invoice/OD-1ZW2",
    readAt: null,
  ),
  Notifications(
    id: "03235a7c-8dbe-4d9a-8e8d-7c468096ce36",
    userId: 2,
    type: "",
    icon: "",
    message: "New payment request.",
    url: "http://127.0.0.1:8000/estimate_booking/invoice/OD-1ZW2",
    readAt: null,
  ),
];
void main() {
  test(
    "See if provider is working",
    () {
      
    },
  );
}
