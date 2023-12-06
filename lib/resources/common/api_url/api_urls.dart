import 'package:flutter/foundation.dart' show immutable;
import 'package:new_user_side/utils/constants/constant.dart';

@immutable
abstract class ApiUrls {
  // static String _base = "https://quantumhostings.com/projects/meinhaus";
  // static String _base = "https://meinhaus.ca";
  static String _base = baseUrl2;
  // static String _base = "https://test.meinhaus.ca";

  static String baseUrl = "$_base/api/";

  static Uri setUrls(String uri) {
    return Uri.parse(baseUrl + uri);
  }

  // Auth
  static Uri auth = setUrls("authenticate");
  static Uri login = setUrls("customer/login");
  static Uri register = setUrls("register");
  static Uri verifyEmail = setUrls("email-verification");
  static Uri verifyMobile = setUrls("mobile-verification");
  static Uri sendOTPMobile = setUrls("send-mobile-otp");
  static Uri resendOtp = setUrls("resend-otp");
  static Uri registerProject = setUrls("project-details");
  static Uri addMobileNo = setUrls("customer/add-mobile");
  static Uri google = setUrls("customer-social-login");
  static Uri userDetails = setUrls("user-details");
  static Uri deleteAccount = setUrls("delete-account");

  // Forget Password
  static Uri forgetPassword = setUrls("send-forgot-password-otp");
  static Uri verifyForgetPasswordOTP = setUrls("verify-forgot-password-otp");
  static Uri createNewPasswordViaFP = setUrls("new-password-with-token");
  static Uri resendForgetPasswordOTP = setUrls("resend-forgot-password-otp");

  // Estimate
  static Uri estimateGeneration = setUrls("estimate-generation");
  static Uri getestimate = setUrls("estimated-work");
  static Uri ongoingProject = setUrls("ongoing-projects");
  static Uri projectHistory = setUrls("projectHistory");
  static String getProjectDetails = "${baseUrl}ongoing-projects/show";
  static String getProDetails = "${baseUrl}show/professional";
  static String progressInvoice = "${baseUrl}progress-invoice";
  static Uri toggleServices = setUrls("toggle-invoice-item");
  static Uri writeReview = setUrls("write-review");

  // Address
  static Uri addAddress = setUrls("add-address");
  static String editAddress = "${baseUrl}edit-addres";
  static Uri deleteAddress = setUrls("delete-address");
  static Uri updateAddress = setUrls("update-address");
  static Uri updateProfile = setUrls("update-profile");
  static Uri updatePassword = setUrls("update-password");
  static Uri setDefaultAddress = setUrls("set-default-address");

  // Additional Work
  static Uri requestAdditional = setUrls("request-additional-work");
  static String getAdditional = "${baseUrl}get-additional-work";
  static Uri approveAdditional = setUrls("approve-additional-work");
  static Uri rejectAdditional = setUrls("reject-additional-work");

  // Check out
  static Uri checkOut = setUrls("checkout");

  // Saved notes
  static Uri savedNoteForMe = setUrls("add-project-notes-for-me");
  static Uri savedNoteForMeAndPro = setUrls("add-project-notes-for-me-other");
  static String getSavedNotes =
      "${baseUrl}get-saved-notes?estimate_service_id=";

  // Our servies
  static Uri ourServices = setUrls("get-services");

  // Customer support
  static Uri sendQuery = setUrls("send-query-to-support");
  static String getRaisedQuery = baseUrl + "raised-query?project_id=";
  static Uri keepOpen = setUrls("send-deny-response");
  static Uri acceptAndClose = setUrls("accept-close-request");

  // Upload Img
  static Uri uploadImg = setUrls("upload-img");

  // Stripe
  static String createIntent = baseUrl + "book-project?booking_id=";

  // Pusher-Chat
  static Uri broadcastAuth = Uri.parse("$_base/broadcasting/auth");
  static Uri allConversation = setUrls("all-conversations");
  static Uri loadMessages = setUrls("load-messages");
  static Uri loadMoreMessages = setUrls("load-more");
  static Uri readMessage = setUrls("trigger-read-event");
  static Uri sendMessage = setUrls("send-message");

  // Notification
  static Uri notification = setUrls("read-notifications");

  // terms and conditions
  static Uri termsAndConditions = Uri.parse("$baseUrl2/terms-and-conditions");
  static Uri privacyPolicies = Uri.parse("$baseUrl2/privacy-policy");
  // static Uri termsAndConditions = setUrls("terms-and-conditions");
}

// https://meinhaus.ca/privacy-policy
