import 'package:flutter_architecture/app/di.dart';
import 'package:flutter_architecture/data/cache/coin/coins_cache.dart';
import 'package:flutter_architecture/data/cache/coin/exchange_rate_cache.dart';

void registerCacheModule() {
  serviceLocator.registerSingleton<CoinsCache>(CoinsCacheImpl());
  serviceLocator.registerSingleton<ExchangeRateCache>(ExchangeRateCacheImpl());
}
