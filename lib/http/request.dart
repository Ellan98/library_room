/*
 * @Date: 2024-07-03 15:49:38
 * @LastEditTime: 2024-07-14 10:49:41
 * @FilePath: \library_room\lib\http\request.dart
 * @description: 注释
 */
import 'package:dio/dio.dart';

const String BaseUrl = "http://127.0.0.1:3000";

final options = BaseOptions(
  baseUrl: BaseUrl,
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 3),
);

final dio = Dio(options); // With default `Options`.


// dio.Interceptors.add(CustomInterceptors());



class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    print('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}