/*
 * @Date: 2024-07-03 15:49:38
 * @LastEditTime: 2024-07-12 14:47:26
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