import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class DataCacheService {
  DataCacheService({required this.apiEndPoint, this.expiryTimeInMinutes = 2});

  final String apiEndPoint;
  final int expiryTimeInMinutes;

  Future<Map<String, dynamic>?> getData() async {
    String endpointValueKey = '$apiEndPoint/value';
    int? saveTime = await getValueTime();
    if (saveTime == null) {
      log("No CacheData Available");
      return null;
    }
    if (saveTime < DateTime.now().millisecondsSinceEpoch) {
      log("No CacheData Available Time Expire");
      setValueTime();
      return null;
    }

    final localBD = await SharedPreferences.getInstance();
    log("Data Form CacheData");
    String? savedStringJSON = localBD.getString(endpointValueKey);
    if (savedStringJSON == null) {
      return null;
    }
    Map<String, dynamic> savedJSON = json.decode(savedStringJSON);
    log("DataCacheService: ${utf8.encode(savedStringJSON).length}");

    return savedJSON;
  }

  Future<int?> getValueTime() async {
    String endpointDateKey = '$apiEndPoint/date';
    final localBD = await SharedPreferences.getInstance();
    int? savedValueTime = localBD.getInt(endpointDateKey);
    return savedValueTime;
  }

  Future<bool> setValueTime() async {
    String endpointDateKey = '$apiEndPoint/date';
    final localBD = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();
    return await localBD.setInt(endpointDateKey,
        now.add(Duration(minutes: expiryTimeInMinutes)).millisecondsSinceEpoch);
  }

  Future setData(Map<String, dynamic> map) async {
    String endpointDateKey = '$apiEndPoint/value';
    final localBD = await SharedPreferences.getInstance();
    String jsonString = json.encode(map);
    bool result = await localBD.setString(endpointDateKey, jsonString);
    result = await setValueTime();
    log("setData: $result");
    return result;
  }

  static removeAllLocalData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? userMapString = await AppLocalStorage.getUserInformation();
    // String? jwt = await AppLocalStorage.getJWT();
    // String? refreshToken = await AppLocalStorage.getRefreshToken();
    await preferences.clear();
    // AppLocalStorage.savedUserInformation(userMapString ?? "");
    // AppLocalStorage.savedJWT(jwt ?? "");
    // AppLocalStorage.savedRefreshToken(refreshToken ?? "");
  }
}
