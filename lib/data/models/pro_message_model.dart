class ProMessagesModel {
  String? status;
  int? conversationId;
  Null endedAt;
  List<Messages>? messages;

  ProMessagesModel(
      {this.status, this.conversationId, this.endedAt, this.messages});

  ProMessagesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    conversationId = json['conversation_id'];
    endedAt = json['ended_at'];
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
    data['ended_at'] = this.endedAt;
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Messages {
  int? id;
  String? senderId;
  String? message;
  String? isSeen;
  String? forwarded;
  String? createdAt;
  String? updatedAt;
  String? type;

  Messages(
      {this.id,
      this.senderId,
      this.message,
      this.isSeen,
      this.forwarded,
      this.createdAt,
      this.updatedAt,
      this.type});

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    message = json['message'];
    isSeen = json['is_seen'];
    forwarded = json['forwarded'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['updated_at'] = this.updatedAt;
    data['type'] = this.type;
    return data;
  }
}