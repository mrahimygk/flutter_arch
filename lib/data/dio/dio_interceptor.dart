import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class DioInterceptor {
  final String TOKEN_QUERY_PARAM_KEY = "token";

  Dio? _dio;

  DioInterceptor();

  Dio getDioInstance() {
    if (_dio == null) {
      _dio = Dio(BaseOptions(connectTimeout: 30000, receiveTimeout: 30000));

      _dio?.interceptors.add(
        InterceptorsWrapper(
          onRequest:
              (RequestOptions options, RequestInterceptorHandler handler) {
                return requestInterceptor(options, handler);
              },
          onResponse: (Response response, ResponseInterceptorHandler handler) {
            return responseInterceptor(response, handler);
          },
          onError: (DioError error, ErrorInterceptorHandler handler) {
            return errorInterceptor(error, _dio!, handler);
          },
        ),
      );
    }
    return _dio!;
  }

  dynamic errorInterceptor(DioError error, Dio dio, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode == 401) {

    }

    return handler.next(error);
  }

  dynamic responseInterceptor(Response response, ResponseInterceptorHandler handler) async {
    Logger().d("[Response] statusCode= ${response.statusCode},\n" +
        "statusMessage= ${response.statusMessage},\n" +
        "headers= ${response.headers},\n" +
        "body= ${response.data},\n");

    return handler.next(response);
  }

  dynamic requestInterceptor(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.queryParameters.addAll(
        {TOKEN_QUERY_PARAM_KEY: "a-DhOKgN46_YiISGrlmb2LT6-0LNJKZ8cNKD7yKkugE"});

    print("[Request] url= ${options.baseUrl}${options.path},\n "
        "headers= ${options.headers},\n "
        "method= ${options.method},\n "
        "queryParameters= ${options.queryParameters}");

    return handler.next(options);
  }
}
