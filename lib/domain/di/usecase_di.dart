import 'package:flutter_architecture/app/di.dart';
import 'package:flutter_architecture/domain/usecase/coin/get_coin_by_id_usecase.dart';
import 'package:flutter_architecture/domain/usecase/coin/get_coin_rates_usecase.dart';
import 'package:flutter_architecture/domain/usecase/coin/get_coins_usecase.dart';
import 'package:flutter_architecture/domain/usecase/coin/get_coin_icons_usecase.dart';
import 'package:flutter_architecture/domain/usecase/get_posts_usecase.dart';
import 'package:flutter_architecture/repository/coins/coins_repository.dart';
import 'package:flutter_architecture/repository/coins/exchange_rates_repository.dart';
import 'package:flutter_architecture/repository/posts_repository.dart';

void registerUseCaseModule() {
  serviceLocator.registerFactory<GetPostsUseCase>(
      () => GetPostsUseCaseImpl(serviceLocator.get<PostsRepository>()));

  serviceLocator.registerFactory<GetCoinsUseCase>(
      () => GetCoinsUseCaseImpl(serviceLocator.get<CoinsRepository>()));

  serviceLocator.registerFactory<GetCoinByIdUseCase>(
          () => GetCoinByIdUseCaseImpl(serviceLocator.get<CoinsRepository>()));

  serviceLocator.registerFactory<GetCoinIconsUseCase>(
      () => GetCoinIconsUseCaseImpl(serviceLocator.get<CoinsRepository>()));

  serviceLocator.registerFactory<GetCoinRatesUseCase>(
      () => GetCoinRatesUseCaseImpl(serviceLocator.get<ExchangeRatesRepository>()));
}
