import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  RetryOnConnectionChangeInterceptor();
  @override
  Future<void> onError(err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.none)) {
        log("Solved : ${err.error is SocketException} ${connectivityResult.isNotEmpty}");
        handler.reject(err);
        return;
      }
    } else {
      if (err.response?.statusCode == 401) {
        // refreshToken(err);
      }
      log("message : No Network Error ${err.type == DioExceptionType.connectionError} ${err.type} -- ${err.message}-- ${err.response!.statusCode}");
      if (err.response == null) {
      } else {}
    }
    super.onError(err, handler);
  }

  bool _shouldRetry(err) {
    return err.type == DioExceptionType.connectionError ||
        err.error is SocketException;
  }

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // final token = await LocalStorage.getJWT();
    // if (token != null && token.isNotEmpty) {
    //   options.headers["Authorization"] = "Bearer $token";
    // }

    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';

    super.onRequest(options, handler);
  }

  // Future<void> refreshToken(DioException err) async {
  //   final refreshToken = await LocalStorage.getRefreshToken();
  //   log("refreshToken : $refreshToken");
  //   final userInformation = {
  //     'refresh_token': refreshToken,
  //     'token': APIEndpoints.panelApiToken,
  //   };
  //   try {
  //     final response = await Dio().get(
  //         APIEndpoints.apiPanelUrl + APIEndpoints.userAuthRefresh,
  //         options: Options(headers: userInformation));
  //     if (response.statusCode == 200) {
  //       String refreshToken = response.data['data']['refreshToken'];
  //       String jwt = response.data['data']['accessToken'];
  //       await LocalStorage.savedRefreshToken(refreshToken);
  //       await LocalStorage.savedJWT(jwt);
  //     } else {
  //       Get.find<AuthController>().userRes.value = null;
  //       await LocalStorage.savedRefreshToken('');
  //       await LocalStorage.savedJWT('');
  //       await LocalStorage.savedUserInformation('');
  //       Get.offNamedUntil("/HomePage", (route) => false);
  //     }
  //   } on dio.DioException catch (_) {
  //     Get.find<AuthController>().userRes.value = null;
  //     await LocalStorage.savedRefreshToken('');
  //     await LocalStorage.savedJWT('');
  //     await LocalStorage.savedUserInformation('');
  //     Get.offNamedUntil("/HomePage", (route) => false);
  //   }
  // }
}
