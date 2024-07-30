import 'api_endpoints.dart';

class APIHeader {
  static Map<String, dynamic> sportsApiHeader = {
    "token": APIEndpoints.cacheServerApiToken,
    // 'ex': Get.find<SplashController>().serverCachesTime,
  };
  // static Map<String, dynamic> panelHeader = {
  //   "os": Platform.isAndroid ? "android" : "ios",
  //   'token': APIEndpoints.panelApiToken,
  // };
}
