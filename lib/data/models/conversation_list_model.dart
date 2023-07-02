class ConversationsListModal {
  String? status;
  List<Conversations>? conversations;

  ConversationsListModal({this.status, this.conversations});

  ConversationsListModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['conversations'] != null) {
      conversations = <Conversations>[];
      json['conversations'].forEach((v) {
        conversations!.add(new Conversations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.conversations != null) {
      data['conversations'] =
          this.conversations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Conversations {
  String? toUserName;
  String? profilePicture;
  String? lastMessageType;
  String? lastMessage;
  String? lastMessageSenderId;
  String? lastMessageCreatedAt;
  int? unreadCount;
  int? conversationId;
  String? fromUserId;
  String? toUserId;

  Conversations(
      {this.toUserName,
      this.profilePicture,
      this.lastMessageType,
      this.lastMessage,
      this.lastMessageSenderId,
      this.lastMessageCreatedAt,
      this.unreadCount,
      this.conversationId,
      this.fromUserId,
      this.toUserId});

  Conversations.fromJson(Map<String, dynamic> json) {
    toUserName = json['to_user_name'];
    profilePicture = json['profile_picture'];
    lastMessageType = json['last_message_type'];
    lastMessage = json['last_message'];
    lastMessageSenderId = json['last_message_sender_id'];
    lastMessageCreatedAt = json['last_message_created_at'];
    unreadCount = json['unread_count'];
    conversationId = json['conversation_id'];
    fromUserId = json['from_user_id'];
    toUserId = json['to_user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['to_user_name'] = this.toUserName;
    data['profile_picture'] = this.profilePicture;
    data['last_message_type'] = this.lastMessageType;
    data['last_message'] = this.lastMessage;
    data['last_message_sender_id'] = this.lastMessageSenderId;
    data['last_message_created_at'] = this.lastMessageCreatedAt;
    data['unread_count'] = this.unreadCount;
    data['conversation_id'] = this.conversationId;
    data['from_user_id'] = this.fromUserId;
    data['to_user_id'] = this.toUserId;
    return data;
  }
}