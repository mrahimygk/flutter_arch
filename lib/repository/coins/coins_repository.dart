import 'package:dio/dio.dart';
import 'package:flutter_architecture/common/transform/coin/coin.dart';
import 'package:flutter_architecture/common/transform/coin/coin_icon.dart';
import 'package:flutter_architecture/data/api/coin/coins_api.dart';
import 'package:flutter_architecture/data/model/coin/coin.dart' as dat;
import 'package:flutter_architecture/data/model/coin/coin_icon.dart' as dat;
import 'package:flutter_architecture/domain/model/base/api_resource.dart';
import 'package:flutter_architecture/domain/model/base/status.dart';
import 'package:flutter_architecture/domain/model/coin/coin.dart' as dom;
import 'package:flutter_architecture/domain/model/coin/coin_icon.dart' as dom;

abstract class CoinsRepository {
  final CoinsApi api;

  CoinsRepository(this.api);

  Stream<ApiResource<List<dom.Coin>>> getCoins();

  Stream<ApiResource<List<dom.CoinIcon>>> getCoinIcons();

  Stream<ApiResource<dom.Coin>> getCoinById(String id);
}

class CoinsRepositoryImpl extends CoinsRepository {
  CoinsRepositoryImpl(CoinsApi postsApi) : super(postsApi);

  @override
  Stream<ApiResource<List<dom.Coin>>> getCoins() async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<List<dom.Coin>> data =
        await api.getCoins().then((List<dat.Coin> value) {
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
        await api.getCoinIcons().then((List<dat.CoinIcon> value) {
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

    final ApiResource<dom.Coin> data = await api.getCoinById(id).then((List<dat.Coin> value) {
      return ApiResource(Status.SUCCESS, value.first.toDomain(), null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, (error as DioError).message);
    });

    yield data;
  }
}
