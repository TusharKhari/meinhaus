class ProMessagesModel {
  String? status;
  int? conversationId;
  int? messageCount;
  List<Messages>? messages;

  ProMessagesModel(
      {this.status, this.conversationId, this.messageCount, this.messages});

  ProMessagesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    conversationId = json['conversation_id'];
    messageCount = json['message_count'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['conversation_id'] = this.conversationId;
    data['message_count'] = this.messageCount;
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Messages {
  int? id;
  dynamic? senderId;
  String? message;
  dynamic? isSeen;
  dynamic? forwarded;
  String? createdAt;
  String? type;

  Messages(
      {this.id,
      this.senderId,
      this.message,
      this.isSeen,
      this.forwarded,
      this.createdAt,
      this.type});

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    message = json['message'];
    isSeen = json['is_seen'];
    forwarded = json['forwarded'];
    createdAt = json['created_at'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender_id'] = this.senderId;
    data['message'] = this.message;
    data['is_seen'] = this.isSeen;
    data['forwarded'] = this.forwarded;
    data['created_at'] = this.createdAt;
    data['type'] = this.type;
    return data;
  }
}
