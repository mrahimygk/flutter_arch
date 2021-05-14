import 'package:flutter_architecture/data/dio/dio_interceptor.dart';
import 'package:flutter_architecture/data/api/plants_api.dart';
import 'package:flutter_architecture/di/di.dart';

void registerApiModule() {
  serviceLocator.registerSingleton(DioInterceptor());

  serviceLocator.registerLazySingleton(() => "https://trefle.io/api/v1/",
      instanceName: "BASE_URL");

  serviceLocator.registerSingleton(PlantsApi(
      serviceLocator<DioInterceptor>().getDioInstance(),
      baseUrl: serviceLocator.get(instanceName: "BASE_URL")));
}
