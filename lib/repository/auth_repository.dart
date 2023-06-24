import 'package:new_user_side/data/network/base_api_services.dart';
import 'package:new_user_side/data/network/network_api_servcies.dart';
import '../res/common/api_url/api_urls.dart';
import '../utils/enum.dart';

class AuthRepositorys {
  NetworkApiServices services = NetworkApiServices();
  BaseApiServices _apiServices = OldNetworkApiServices();

// Login
  Future<ResponseType> login(MapSS body) async {
    try {
      return await services.sendHttpRequestWithoutHeader(
        url: ApiUrls.signIn,
        method: HttpMethod.post,
        body: body,
        allowUnauthorizedResponse: true,
      );
    } catch (e) {
      throw e;
    }
  }

// Auth
  Future<ResponseType> auth() async {
    try {
      return await services.sendHttpRequest(
        url: ApiUrls.auth,
        method: HttpMethod.get,
      );
    } catch (e) {
      throw e;
    }
  }

// SignUp
  Future<ResponseType> signUp(MapSS data) async {
    try {
      return await services.sendHttpRequestWithoutHeader(
        url: ApiUrls.signUp,
        method: HttpMethod.post,
        body: data,
      );
    } catch (e) {
      throw e;
    }
  }

// Verify Otp
  Future<ResponseType> verifyEmail(MapSS data) async {
    try {
      return await services.sendHttpRequestWithoutHeader(
        url: ApiUrls.verifyEmail,
        method: HttpMethod.post,
        body: data,
      );
    } catch (e) {
      throw e;
    }
  }

// User Details
  Future<ResponseType> userDetails(MapSS data) async {
    try {
      return await services.sendHttpRequestWithoutHeader(
        url: ApiUrls.userDetails,
        method: HttpMethod.post,
        body: data,
      );
    } catch (e) {
      throw e;
    }
  }

  // Social Login
  Future<ResponseType> googleLogin(MapSS data) async {
    try {
      return await services.sendHttpRequestWithoutHeader(
        url: ApiUrls.google,
        method: HttpMethod.post,
        body: data,
      );
    } catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>> google(ResponseType data) async {
    try {
      return await _apiServices.postApiWithoutHeader(ApiUrls.google, data);
    } catch (e) {
      throw e;
    }
  }
}
