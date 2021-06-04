import 'package:flutter_architecture/data/api/coin/coins_api.dart';
import 'package:flutter_architecture/data/api/coin/exchange_rate_api.dart';
import 'package:flutter_architecture/data/api/posts_api.dart';
import 'package:flutter_architecture/app/di.dart';
import 'package:flutter_architecture/repository/coins/coins_repository.dart';
import 'package:flutter_architecture/repository/coins/exchange_rates_repository.dart';
import 'package:flutter_architecture/repository/posts_repository.dart';

void registerRepositoryModule() {
  serviceLocator.registerFactory<PostsRepository>(
      () => PostsRepositoryImpl(serviceLocator.get<PostsApi>()));

  serviceLocator.registerFactory<CoinsRepository>(
      () => CoinsRepositoryImpl(serviceLocator.get<CoinsApi>()));

  serviceLocator.registerFactory<ExchangeRatesRepository>(
      () => ExchangeRatesRepositoryImpl(serviceLocator.get<ExchangeRateApi>()));
}
