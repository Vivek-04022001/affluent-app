class AppConfig {
  static const bool isProduction = false;
  static const String appName = "Affluent";
  static const String appVersion = "1.0.0";
  static const String appBaseUrl = "https://www.sunhilempire.com";
  static const String appApiUrl = "$appBaseUrl/api/user/";
  static const String apiKey = "Affluent";
  static const String downloadUrl = "$appBaseUrl/storage/";
  static const String projectImageUrl = "$appBaseUrl/uploads/projects/";
  static const String supportImageUrl = "$appBaseUrl/uploads/";
  static const int maxSizeInMBDocumentUpload = 5;
  static const int maxSizeInMBImageUpload = 2;
  static const int maxSizeInMBVideoUpload = 10;

  //===Desing===
  static const double textFieldBorderRadius = 12.0;
  static const double kDefaultSpacing = 16.0;

  //=== Restricted Paths===
  static const String kAuthExpiredRedirectPath = '/otp-request';

  //===App Images ===
  static const String imageBasePath = 'assets/images/';
}
