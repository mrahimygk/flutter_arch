import 'package:dio/dio.dart';
import 'package:flutter_architecture/data/model/coin/exchange_rate_response.dart';
import 'package:retrofit/retrofit.dart';

part 'exchange_rate_api.g.dart';

@RestApi()
abstract class ExchangeRateApi {
  factory ExchangeRateApi(Dio dio, {String? baseUrl}) = _ExchangeRateApi;

  @GET("exchangerate/{id}/")
  Future<ExchangeRateResponse> getExchangeRatesForCoin(@Path("id") String id);
}
