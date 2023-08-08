class NotificationsModel {
  bool? success;
  List<Notifications>? notifications;

  NotificationsModel({this.success, this.notifications});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  String? id;
  int? userId;
  String? type;
  String? icon;
  String? message;
  String? url;
  Null readAt;

  Notifications(
      {this.id,
      this.userId,
      this.type,
      this.icon,
      this.message,
      this.url,
      this.readAt});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    type = json['type'];
    icon = json['icon'];
    message = json['message'];
    url = json['url'];
    readAt = json['read_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['icon'] = this.icon;
    data['message'] = this.message;
    data['url'] = this.url;
    data['read_at'] = this.readAt;
    return data;
  }
}