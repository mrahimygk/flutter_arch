import 'package:flutter_architecture/data/model/coin/exchange_rate_response.dart';
import 'package:flutter_architecture/data/model/coin/history_period.dart';
import 'package:flutter_architecture/data/model/coin/rate_history.dart';
import 'package:retrofit/retrofit.dart';

abstract class ExchangeRateCache {
  /// periodId to HistoryPeriod
  Map<String, HistoryPeriod>? historyPeriods;

  /// coinId to ExchangeRateResponse
  Map<String, ExchangeRateResponse>? exchangeRatesForCoin;

  /// base_id to (quote_id to RateHistory)
  Map<String, RateHistory>? rateHistoryForTwoCoins;

  @GET("exchangerate/history/periods/")
  Future<List<HistoryPeriod>> getHistoryPeriods();

  @GET("exchangerate/{id}/")
  Future<ExchangeRateResponse> getExchangeRatesForCoin(@Path("id") String id);

  @GET("exchangerate/{base_id}/{quote_id}/history/")
  Future<List<RateHistory>> getRateHistoryForTwoCoins(
    @Path("base_id") String baseCoinId,
    @Path("quote_id") String quoteCoinId,
    @Query("time_start") String? startTime,
    @Query("time_end") String? endTime,
    @Query("period_id") String periodId,
  );
}
