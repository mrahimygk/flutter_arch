import 'package:flutter_architecture/data/model/coin/exchange_rate_response.dart';
import 'package:flutter_architecture/data/model/coin/history_period.dart';
import 'package:flutter_architecture/data/model/coin/rate_history.dart';
import 'package:flutter_architecture/domain/model/coin/rate_history_request.dart';

abstract class ExchangeRateCache {
  // @GET("exchangerate/history/periods/")
  Future<List<HistoryPeriod>> getHistoryPeriods();

  Future<ExchangeRateResponse>? getExchangeRatesForCoin(String id);

  Future<List<RateHistory>>? getRateHistoryForTwoCoins(
      RateHistoryRequest request);

  void putExchangeRatesForCoin(ExchangeRateResponse response);

  void putRateHistoryForTwoCoins(
    RateHistoryRequest request,
    List<RateHistory> value,
  );
}

class ExchangeRateCacheImpl extends ExchangeRateCache {
  /// periodId to HistoryPeriod
  Map<String, HistoryPeriod>? historyPeriods;

  /// coinId to ExchangeRateResponse
  Map<String, ExchangeRateResponse>? exchangeRatesForCoin;

  /// base_id to (quote_id to RateHistory)
  Map<String, List<RateHistory>>? rateHistoryForTwoCoins;

  @override
  Future<ExchangeRateResponse>? getExchangeRatesForCoin(String id) =>
      exchangeRatesForCoin == null || !exchangeRatesForCoin!.keys.contains(id)
          ? null
          : Future.value(exchangeRatesForCoin![id]);

  @override
  Future<List<HistoryPeriod>> getHistoryPeriods() {
    // TODO: implement getHistoryPeriods
    throw UnimplementedError();
  }

  @override
  Future<List<RateHistory>>? getRateHistoryForTwoCoins(
      RateHistoryRequest request) {
    final key =
        "${request.baseId}${request.quoteId}${request.periodId}${request.startTime}${request.endTime}";
    return rateHistoryForTwoCoins == null ||
            !rateHistoryForTwoCoins!.containsKey(key)
        ? null
        : Future.value(rateHistoryForTwoCoins![key]);
  }

  @override
  void putExchangeRatesForCoin(ExchangeRateResponse response) {
    if (exchangeRatesForCoin == null) {
      exchangeRatesForCoin = Map<String, ExchangeRateResponse>();
    }
    exchangeRatesForCoin![response.coinId] = response;
  }

  @override
  void putRateHistoryForTwoCoins(
      RateHistoryRequest request, List<RateHistory> value) {
    if (rateHistoryForTwoCoins == null) {
      rateHistoryForTwoCoins = Map<String, List<RateHistory>>();
    }
    final key =
        "${request.baseId}${request.quoteId}${request.periodId}${request.startTime}${request.endTime}";
    rateHistoryForTwoCoins![key] = value;
  }
}
