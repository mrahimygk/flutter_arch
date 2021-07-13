import 'package:dio/dio.dart';
import 'package:flutter_architecture/data/dio/dio_interceptor.dart';

class CoinApiInterceptor extends DioInterceptor {
  final String API_KEY_QUERY_PARAM_KEY = "apikey";
  final String API_KEY_HEADER_KEY = "X-CoinAPI-Key";

  @override
  dynamic requestInterceptor(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.queryParameters.addAll(
        {API_KEY_QUERY_PARAM_KEY: "GET_API_KEY"});
    options.headers
        .addAll({API_KEY_HEADER_KEY: "GET_API_KEY"});

    print("[Request] url= ${options.baseUrl}${options.path},\n "
        "headers= ${options.headers},\n "
        "method= ${options.method},\n "
        "queryParameters= ${options.queryParameters}");

    return handler.next(options);
  }
}
