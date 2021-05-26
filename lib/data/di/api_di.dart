import 'package:flutter_architecture/data/api/coin/coins_api.dart';
import 'package:flutter_architecture/data/dio/coinapi_interceptor.dart';
import 'package:flutter_architecture/data/dio/dio_interceptor.dart';
import 'package:flutter_architecture/data/api/posts_api.dart';
import 'package:flutter_architecture/di.dart';

void registerApiModule() {
  serviceLocator.registerSingleton(DioInterceptor());
  serviceLocator.registerSingleton(CoinApiInterceptor());

  serviceLocator.registerLazySingleton(() => "https://jsonplaceholder.typicode.com/",
      instanceName: "BASE_URL");

  serviceLocator.registerLazySingleton(() => "https://rest.coinapi.io/v1/",
      instanceName: "BASE_URL_COIN_API");

  serviceLocator.registerSingleton(PostsApi(
      serviceLocator<DioInterceptor>().getDioInstance(),
      baseUrl: serviceLocator.get(instanceName: "BASE_URL")));

  serviceLocator.registerSingleton(CoinsApi(
      serviceLocator<CoinApiInterceptor>().getDioInstance(),
      baseUrl: serviceLocator.get(instanceName: "BASE_URL_COIN_API")));
}
