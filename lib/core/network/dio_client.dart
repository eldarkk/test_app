import 'package:dio/dio.dart';
import 'package:test_app/core/network/clean_json_intercepter.dart';

class DioClient {
  late final Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://media.jefe-stg.idtm.io/programming-test/api/',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        responseType: ResponseType.plain, // Set response type to plain
      ),
    );

    dio.interceptors.addAll([
      CleanJsonInterceptor(),
      LogInterceptor(
        requestHeader: false,
        responseHeader: false,
        responseBody: true,
      ),
    ]);
  }
}
