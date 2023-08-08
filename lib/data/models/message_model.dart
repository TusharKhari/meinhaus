// ignore_for_file: public_member_api_docs, sort_constructors_first
class MessageModel {
  String? status;
  int? conversationId;
  int? toUserId;
  int? messageCount;
  List<Messages>? messages;

  MessageModel(
      {this.status,
      this.conversationId,
      this.toUserId,
      this.messageCount,
      this.messages});

  MessageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    conversationId = json['conversation_id'];
    toUserId = json['to_user_id'];
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
    data['to_user_id'] = this.toUserId;
    data['message_count'] = this.messageCount;
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  MessageModel copyWith({
    String? status,
    int? conversationId,
    int? toUserId,
    int? messageCount,
    List<Messages>? messages,
  }) {
    return MessageModel(
      status: status ?? this.status,
      conversationId: conversationId ?? this.conversationId,
      toUserId: toUserId ?? this.toUserId,
      messageCount: messageCount ?? this.messageCount,
      messages: messages ?? this.messages,
    );
  }
}

class Messages {
  int? id;
  int? senderId;
  String? message;
  int? isSeen;
  int? forwarded;
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

  Messages copyWith({
    int? id,
    int? senderId,
    String? message,
    int? isSeen,
    int? forwarded,
    String? createdAt,
    String? type,
  }) {
    return Messages(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      message: message ?? this.message,
      isSeen: isSeen ?? this.isSeen,
      forwarded: forwarded ?? this.forwarded,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
    );
  }
}
