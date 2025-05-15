import 'package:sehetne_provider/main.dart';

Map<String, String> header = {
  'Authorization': 'Bearer ${pref.getString("token")}',
  "Accept": "application/json",
};
String baseUrl = "https://api.sehtnaa.com/api";
String authBaseIrl = "$baseUrl/auth";
String resetPasswordBase = "$baseUrl/reset-password";
String providerBase = "$baseUrl/provider";
String userBase = "$baseUrl/user";
String requestsBase = "$baseUrl/requests";
String imagesBaseUrl = "https://api.sehtnaa.com/storage";

//Auth

String registerApi = "$authBaseIrl/register";
String logOutApi = "$authBaseIrl/logout";
String loginApi = "$authBaseIrl/login";
String sendCodeApi = "$resetPasswordBase/send-code";
String otpApi = "$resetPasswordBase/verify-code";
String resetPasswordApi = "$resetPasswordBase/reset";

//provider

String uploadDocsApi = "$providerBase/upload-document";
String requiredDocsApi = "$providerBase/required-documents";
String decumentsStatusApi = "$providerBase/document-status";
String getFeedBacksApi = "$providerBase/feedbacks";
String getComplaintApi = "$providerBase/complaints";
String getAnalyticsApi = "$providerBase/analytics";
String changeStatusApi = "$providerBase/availability";
String acceptRequestApi = "$providerBase/accept";
String completeRequestApi = "$providerBase/complete";

String updateProfileApi = "$userBase/update-profile";
String updateProfileImageApi = "$userBase/update-profile-image";
String updatePasswordApi = "$userBase/update-password";
String getOngoingRequestsApi = "$userBase/ongoing-requests";
