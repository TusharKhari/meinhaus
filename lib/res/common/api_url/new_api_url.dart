class NewApiUrls {
  static String baseUrl = "https://meinhaus.ca/meinhaus/api/";

  static Uri setUrls(String uri) {
    return Uri.parse(baseUrl + uri);
  }

  // Auth
  static Uri auth = setUrls("authenticate");
  static Uri login = setUrls("customer/login");
  static Uri register = setUrls("register");
  static Uri verifyEmail = setUrls("verify-email");
  static Uri verifyMobile = setUrls("mobile-verification");
  static Uri resendOtp = setUrls("resend-otp");
  static Uri registerProject = setUrls("project-details");
  static Uri addMobileNo = setUrls("customer/add-mobile");
  static Uri google = setUrls("customer-social-login");
  
}
