import 'package:dio/dio.dart';
import 'package:flutter_architecture/common/transform/coin/exchange_rate.dart';
import 'package:flutter_architecture/common/transform/coin/history_period.dart';
import 'package:flutter_architecture/common/transform/coin/rate_history.dart';
import 'package:flutter_architecture/data/api/coin/exchange_rate_api.dart';
import 'package:flutter_architecture/data/model/coin/exchange_rate.dart' as dat;
import 'package:flutter_architecture/data/model/coin/exchange_rate_response.dart';
import 'package:flutter_architecture/data/model/coin/history_period.dart'
    as dat;
import 'package:flutter_architecture/data/model/coin/rate_history.dart'
    as dat;
import 'package:flutter_architecture/domain/model/base/api_resource.dart';
import 'package:flutter_architecture/domain/model/base/status.dart';
import 'package:flutter_architecture/domain/model/coin/exchange_rate.dart'
    as dom;
import 'package:flutter_architecture/domain/model/coin/history_period.dart'
    as dom;
import 'package:flutter_architecture/domain/model/coin/rate_history.dart'
    as dom;
import 'package:flutter_architecture/domain/model/coin/rate_history_request.dart';

abstract class ExchangeRatesRepository {
  final ExchangeRateApi api;

  ExchangeRatesRepository(this.api);

  Stream<ApiResource<List<dom.ExchangeRate>>> getExchangeRatesForCoin(
      String id);

  Stream<ApiResource<List<dom.HistoryPeriod>>> getHistoryPeriods();

  Stream<ApiResource<List<dom.RateHistory>>> getRateHistoryForTwoCoins(
      RateHistoryRequest request);
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

  @override
  Stream<ApiResource<List<dom.HistoryPeriod>>> getHistoryPeriods() async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<List<dom.HistoryPeriod>> data =
        await api.getHistoryPeriods().then((List<dat.HistoryPeriod> value) {
      return ApiResource(Status.SUCCESS,
          value.map((dat.HistoryPeriod e) => e.toDomain()).toList(), null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, (error as DioError).message);
    });

    yield data;
  }

  @override
  Stream<ApiResource<List<dom.RateHistory>>> getRateHistoryForTwoCoins(
      RateHistoryRequest request) async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<List<dom.RateHistory>> data = await api
        .getRateHistoryForTwoCoins(
      request.baseId,
      request.quoteId,
      request.startTime,
      request.endTime,
      request.periodId,
    )
        .then((List<dat.RateHistory> value) {
      return ApiResource(Status.SUCCESS,
          value.map((dat.RateHistory e) => e.toDomain()).toList(), null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, (error as DioError).message);
    });

    yield data;
  }
}
