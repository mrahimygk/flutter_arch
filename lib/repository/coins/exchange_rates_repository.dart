import 'package:dio/dio.dart';
import 'package:flutter_architecture/common/transform/coin/exchange_rate.dart';
import 'package:flutter_architecture/data/api/coin/exchange_rate_api.dart';
import 'package:flutter_architecture/data/model/coin/exchange_rate.dart' as dat;
import 'package:flutter_architecture/data/model/coin/exchange_rate_response.dart';
import 'package:flutter_architecture/domain/model/base/api_resource.dart';
import 'package:flutter_architecture/domain/model/base/status.dart';
import 'package:flutter_architecture/domain/model/coin/exchange_rate.dart'
    as dom;

abstract class ExchangeRatesRepository {
  final ExchangeRateApi api;

  ExchangeRatesRepository(this.api);

  Stream<ApiResource<List<dom.ExchangeRate>>> getExchangeRatesForCoin(
      String id);
}

class ExchangeRatesRepositoryImpl extends ExchangeRatesRepository {
  ExchangeRatesRepositoryImpl(ExchangeRateApi postsApi) : super(postsApi);

  @override
  Stream<ApiResource<List<dom.ExchangeRate>>> getExchangeRatesForCoin(
      String id) async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<List<dom.ExchangeRate>> data = await api
        .getExchangeRatesForCoin(id)
        .then((ExchangeRateResponse value) {
      return ApiResource(Status.SUCCESS,
          value.rates.map((dat.ExchangeRate e) => e.toDomain()).toList(), null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, (error as DioError).message);
    });

    yield data;
  }
}
