import 'package:dio/dio.dart';
import 'package:flutter_architecture/data/model/coin/exchange_rate_response.dart';
import 'package:flutter_architecture/data/model/coin/history_period.dart';
import 'package:flutter_architecture/data/model/coin/rate_history.dart';
import 'package:retrofit/retrofit.dart';

part 'exchange_rate_api.g.dart';

@RestApi()
abstract class ExchangeRateApi {
  factory ExchangeRateApi(Dio dio, {String? baseUrl}) = _ExchangeRateApi;

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
