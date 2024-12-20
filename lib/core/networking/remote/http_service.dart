import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoints.dart';
import 'package:final_assignment/core/networking/remote/dio_error_interceptor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final httpServiceProvider = Provider<Dio>(
  (ref) => HttpService(Dio()).dio,
);

class HttpService {
  final Dio _dio;

  HttpService(this._dio) {
    _dio
      ..options.baseUrl = ApiEndpoints.baseUrl
      ..options.connectTimeout = ApiEndpoints.connectionTimeout
      ..options.receiveTimeout = ApiEndpoints.receiveTimeout
      ..interceptors.add(DioErrorInterceptor())
      ..interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true))
      ..options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
  }

  Dio get dio => _dio;
}
