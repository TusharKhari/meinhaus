import 'package:new_user_side/data/network/base_api_services.dart';
import 'package:new_user_side/data/network/network_api_servcies.dart';
import 'package:new_user_side/res/common/api_url/new_api_url.dart';
import '../res/common/api_url/api_urls.dart';
import '../utils/enum.dart';

class AuthRepositorys {
  NetworkApiServices services = NetworkApiServices();
  BaseApiServices _apiServices = OldNetworkApiServices();

// Login
  Future<ResponseType> login(MapSS body) async {
    try {
      return await services.sendHttpRequestWithoutHeader(
        url: NewApiUrls.login,
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
        url: NewApiUrls.register,
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
        url: NewApiUrls.verifyMobile,
        method: HttpMethod.post,
        body: data,
      );
    } catch (e) {
      throw e;
    }
  }

  // Resend Otp
  Future<ResponseType> resendOtp(MapSS data) async {
    try {
      return await services.sendHttpRequestWithoutHeader(
        url: NewApiUrls.resendOtp,
        method: HttpMethod.post,
        body: data,
      );
    } catch (e) {
      throw e;
    }
  }

  // Add Phone number
  Future<ResponseType> addPhoneNo(MapSS data) async {
    try {
      return await services.sendHttpRequest(
        url: NewApiUrls.addMobileNo,
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

  // Forget Password
  Future<ResponseType> forgetPassword(MapSS body) async {
    try {
      return await services.sendHttpRequestWithoutHeader(
        url: ApiUrls.forgetPassword,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      throw e;
    }
  }

  // Verify Forget Password OTP
  Future<ResponseType> verifyForgetPassOTP(MapSS body) async {
    try {
      return await services.sendHttpRequestWithoutHeader(
        url: ApiUrls.verifyForgetPasswordOTP,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      throw e;
    }
  }

  // Create New password via Forget Password
  Future<ResponseType> createNewPasswordViaFP(MapSS body) async {
    try {
      return await services.sendHttpRequestWithoutHeader(
        url: ApiUrls.createNewPasswordViaFP,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      throw e;
    }
  }

  // Resend Forget Password OTP
  Future<ResponseType> resendFOrgetPassOTP(MapSS body) async {
    try {
      return await services.sendHttpRequestWithoutHeader(
        url: ApiUrls.resendForgetPasswordOTP,
        method: HttpMethod.post,
        body: body,
        allowUnauthorizedResponse: true,
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
