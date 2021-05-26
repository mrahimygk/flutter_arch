import 'package:flutter_architecture/di.dart';
import 'package:flutter_architecture/domain/usecase/coin/get_coins_usecase.dart';
import 'package:flutter_architecture/domain/usecase/coin/get_coin_icons_usecase.dart';
import 'package:flutter_architecture/domain/usecase/get_posts_usecase.dart';
import 'package:flutter_architecture/repository/coins/coins_repository.dart';
import 'package:flutter_architecture/repository/posts_repository.dart';

void registerUseCaseModule() {
  serviceLocator.registerFactory<GetPostsUseCase>(
      () => GetPostsUseCaseImpl(serviceLocator.get<PostsRepository>()));

  serviceLocator.registerFactory<GetCoinsUseCase>(
      () => GetCoinsUseCaseImpl(serviceLocator.get<CoinsRepository>()));

  serviceLocator.registerFactory<GetCoinIconsUseCase>(
      () => GetCoinIconsUseCaseImpl(serviceLocator.get<CoinsRepository>()));
}
