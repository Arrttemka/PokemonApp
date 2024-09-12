import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';


class DioSettings {
  DioSettings() {
  setup();
} 


 Dio dio = Dio(
  BaseOptions(
    baseUrl: 'https://sandbox.avn.kg/wp/api/mobile/v1/',
    contentType: 'application/json',
    headers: {'Accept': 'application/json'},
    connectTimeout: Duration(seconds: 20),
    receiveTimeout: Duration(seconds: 20)),
);

void setup() async {
  final interceptors = dio.interceptors;

  interceptors.clear();
  final loginterceptor = Loginterceptor(
    request: true,
  requestBody: true,
  requestHeader: true,
  responseBody: true,
  responseHeader: true,
);

final headerInterceptors = QueuedInterceptorsWrapper(
  onRequest: (options, handler) => handler.next(options),
  onError: (DioException error, handler) {
  handler.next(error);
  },
  onResponse: (response, handler) {
    return handler.next(response);
  },
);
  interceptors.addAll([if (kDebugMode) logInterceptor, headerInterceptors]);
  }
}