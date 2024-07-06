class ApiConstants {
  static String baseUrl = "http://13.60.93.136:8080";
  static String s3Url = "https://iittnif-bucket.s3.eu-north-1.amazonaws.com";
  static String login = "/iitt/login";
  static String uploadData = "/uploadImage";
  static String register = "/iitt/register";
  static String getActivity = "/iitt/getUserUploads/"; // add user id at end
  static String getUser = "/iitt/getUser";
  static String getLeaderBoard = "/iitt/getLeaderBoard";
  static String updateProfile = "/iitt/updateProfile";
  static String sendEmail = "/iitt/sendEmail";
  static String verifyOtp = "/iitt/verifyOtp";
  static String sendSms = "/iitt/sendSms";
  static String verifySms = "/iitt/verifySms";
  static String expiredOtp = "/iitt/expiredOtp";
  static String resetPasswordEmail = "/iitt/resetPasswordEmail";
  static String resetPassword = "/iitt/resetPassword";
  static String deleteData = "/iitt/deleteData";
}
