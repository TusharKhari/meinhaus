import 'package:new_user_side/data/network/network_api_servcies.dart';
import '../res/common/api_url/api_urls.dart';
import '../utils/enum.dart';

class ChatWithProRepo {
  NetworkApiServices services = NetworkApiServices();

// Get Conversation List
  Future<ResponseType> allConversation() async {
    try {
      return await services.sendHttpRequest(
        url: ApiUrls.allConversation,
        method: HttpMethod.get,
      );
    } catch (e) {
      throw e;
    }
  }

// Load Messages
  Future<ResponseType> loadMessages(MapSS body) async {
    try {
      return await services.sendHttpRequest(
        url: ApiUrls.loadMessages,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      throw e;
    }
  }

  // Load Messages
  Future<ResponseType> loadMoreMessages(MapSS body) async {
    try {
      return await services.sendHttpRequest(
        url: ApiUrls.loadMoreMessages,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      throw e;
    }
  }

  // Send Message
  Future<ResponseType> sendMessage(MapSS body) async {
    try {
      return await services.sendHttpRequest(
        url: ApiUrls.sendMessage,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      throw e;
    }
  }

  // Read Message
  Future<ResponseType> readMessage(MapSS body) async {
    try {
      return await services.sendHttpRequest(
        url: ApiUrls.readMessage,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      throw e;
    }
  }
}
