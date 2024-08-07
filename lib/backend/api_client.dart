import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'retry_on_connection_change_intercptor.dart';

enum ApiRequestType { get, post, put }

class ApiClient {
  static final Dio _dio = Dio(
    BaseOptions(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        connectTimeout: const Duration(minutes: 2),
        receiveTimeout: const Duration(minutes: 2)),
  );

  static remoteApiCall({
    required String apiUrl,
    required ApiRequestType reqType,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    required Function(Response response) ifSucceed,
    Function(ApiException)? ifFailed,
    Function? ifLoading,
    dynamic data,
  }) async {
    _dio.interceptors.add(RetryOnConnectionChangeInterceptor());

    try {
      await ifLoading?.call();
      late Response response;
      if (reqType == ApiRequestType.get) {
        response = await _dio.get(
          apiUrl,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
          ),
        );
      } else if (reqType == ApiRequestType.post) {
        response = await _dio.post(
          apiUrl,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        );
      } else if (reqType == ApiRequestType.put) {
        response = await _dio.put(
          apiUrl,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        );
      }
      return await ifSucceed(response);
    } on DioException catch (error) {
      Logger().e(error);
      log("error: ${error.requestOptions.path} -- ${error.response?.data}");
      return ifFailed!(ApiException(
          url: error.requestOptions.path,
          message: error.response?.data['msg'] ??
              error.response?.data['message'] ??
              "${error.message}"));
    } on TimeoutException {
      Logger().e("Connection Timeout");
      return ifFailed!(ApiException(url: '', message: "Connection Timeout"));
    } catch (error, stackTrace) {
      Logger().e(stackTrace);
      return ifFailed!(
          ApiException(url: stackTrace.toString(), message: error.toString()));
    }
  }
}

class ApiException implements Exception {
  final String url;
  final String message;
  final int? statusCode;
  final Response? response;
  ApiException({
    required this.url,
    required this.message,
    this.response,
    this.statusCode,
  });
  @override
  toString() {
    String result = '';
    result += response?.data?['error'] ?? '';
    if (result.isEmpty) {
      result += message;
    }
    return result;
  }
}
