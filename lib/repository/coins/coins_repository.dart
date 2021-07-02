import 'package:dio/dio.dart';
import 'package:flutter_architecture/common/transform/coin/coin.dart';
import 'package:flutter_architecture/common/transform/coin/coin_icon.dart';
import 'package:flutter_architecture/data/api/coin/coins_api.dart';
import 'package:flutter_architecture/data/cache/coin/coins_cache.dart';
import 'package:flutter_architecture/data/model/coin/coin.dart' as dat;
import 'package:flutter_architecture/data/model/coin/coin_icon.dart' as dat;
import 'package:flutter_architecture/domain/model/base/api_resource.dart';
import 'package:flutter_architecture/domain/model/base/status.dart';
import 'package:flutter_architecture/domain/model/coin/coin.dart' as dom;
import 'package:flutter_architecture/domain/model/coin/coin_icon.dart' as dom;

abstract class CoinsRepository {
  final CoinsApi api;
  final CoinsCache memoryCache;

  CoinsRepository(this.api, this.memoryCache);

  Stream<ApiResource<List<dom.Coin>>> getCoins();

  Stream<ApiResource<List<dom.CoinIcon>>> getCoinIcons();

  Stream<ApiResource<dom.Coin>> getCoinById(String id);
}

class CoinsRepositoryImpl extends CoinsRepository {
  CoinsRepositoryImpl(CoinsApi api, CoinsCache memoryCache)
      : super(api, memoryCache);

  @override
  Stream<ApiResource<List<dom.Coin>>> getCoins() async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<List<dom.Coin>> data =
        await (memoryCache.getCoins() ?? api.getCoins())
            .then((List<dat.Coin> value) {
      memoryCache.putCoins(value);
      return ApiResource(Status.SUCCESS,
          value.map((dat.Coin e) => e.toDomain()).toList(), null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, (error as DioError).message);
    });

    yield data;
  }

  @override
  Stream<ApiResource<List<dom.CoinIcon>>> getCoinIcons() async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<List<dom.CoinIcon>> data =
        await (memoryCache.getCoinIcons() ?? api.getCoinIcons())
            .then((List<dat.CoinIcon> value) {
      memoryCache.putCoinIcons(value);
      return ApiResource(
          Status.SUCCESS,
          value.map((dat.CoinIcon e) {
            return e.toDomain();
          }).toList(),
          null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, (error as DioError).message);
    });

    yield data;
  }

  @override
  Stream<ApiResource<dom.Coin>> getCoinById(String id) async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<dom.Coin> data =
        await (memoryCache.getCoinById(id) ?? api.getCoinById(id))
            .then((List<dat.Coin> value) {
      memoryCache.putCoin(value.first);
      return ApiResource(Status.SUCCESS, value.first.toDomain(), null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, (error as DioError).message);
    });

    yield data;
  }
}
