import 'package:flutter_architecture/data/dio/dio_interceptor.dart';
import 'package:flutter_architecture/data/api/posts_api.dart';
import 'package:flutter_architecture/di.dart';

void registerApiModule() {
  serviceLocator.registerSingleton(DioInterceptor());

  serviceLocator.registerLazySingleton(() => "https://jsonplaceholder.typicode.com/",
      instanceName: "BASE_URL");

  serviceLocator.registerSingleton(PostsApi(
      serviceLocator<DioInterceptor>().getDioInstance(),
      baseUrl: serviceLocator.get(instanceName: "BASE_URL")));
}
