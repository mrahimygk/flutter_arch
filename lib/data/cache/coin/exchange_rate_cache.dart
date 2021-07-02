import 'package:flutter_architecture/data/model/coin/exchange_rate_response.dart';
import 'package:flutter_architecture/data/model/coin/history_period.dart';
import 'package:flutter_architecture/data/model/coin/rate_history.dart';

abstract class ExchangeRateCache {
  // @GET("exchangerate/history/periods/")
  Future<List<HistoryPeriod>> getHistoryPeriods();

  Future<ExchangeRateResponse>? getExchangeRatesForCoin(String id);

/*@GET("exchangerate/{base_id}/{quote_id}/history/")
  Future<List<RateHistory>> getRateHistoryForTwoCoins(
    @Path("base_id") String baseCoinId,
    @Path("quote_id") String quoteCoinId,
    @Query("time_start") String? startTime,
    @Query("time_end") String? endTime,
    @Query("period_id") String periodId,
  );*/

  void putExchangeRatesForCoin(ExchangeRateResponse response);
}

class ExchangeRateCacheImpl extends ExchangeRateCache {
  /// periodId to HistoryPeriod
  Map<String, HistoryPeriod>? historyPeriods;

  /// coinId to ExchangeRateResponse
  Map<String, ExchangeRateResponse>? exchangeRatesForCoin;

  /// base_id to (quote_id to RateHistory)
  Map<String, RateHistory>? rateHistoryForTwoCoins;

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
  void putExchangeRatesForCoin(ExchangeRateResponse response) {
    if (exchangeRatesForCoin == null) {
      exchangeRatesForCoin = Map<String, ExchangeRateResponse>();
    }
    exchangeRatesForCoin![response.coinId] = response;
  }
}
