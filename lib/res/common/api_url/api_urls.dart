class ApiUrls {
  static String baseUrl = "https://meinhaus.ca/api/";

  static Uri setUrls(String uri) {
    return Uri.parse(baseUrl + uri);
  }

  // Auth
  static Uri signIn = setUrls("login");
  static Uri signUp = setUrls("signup");
  static Uri verifyEmail = setUrls("verify-email");
  static Uri auth = setUrls("authenticate");
  static Uri userDetails = setUrls("user-details");
  static Uri google = setUrls("customer-social-login");

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

  // Additional Work
  static Uri requestAdditional = setUrls("request-additional-work");
  static String getAdditional = "${baseUrl}get-additional-work";
  static Uri approveAdditional = setUrls("approve-additional-work");
  static Uri rejectAdditional = setUrls("reject-additional-work");

  // Check out
  static Uri checkOut = setUrls("checkout");

  // Saved notes
  static Uri savedNoteForMe = setUrls("add-project-notes-for-me");
  static Uri savedNoteForMeAndPro = setUrls("add-project-notes-for-me-pro");
  static String getSavedNotes = "${baseUrl}add-project-notes-for-me-pro";

  // Our servies
  static Uri ourServices = setUrls("get-services");

  // Customer support
  static Uri sendQuery = setUrls("send-query-to-support");
  static String getRaisedQuery = baseUrl + "raised-query?project_id=";

  // Upload Img
  static Uri uploadImg = setUrls("upload-img");

  // Chat with pro
  static Uri allConversation = setUrls("all-conversations");
  static Uri loadMessages = setUrls("load-messages");
}
