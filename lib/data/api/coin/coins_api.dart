import 'package:dio/dio.dart';
import 'package:flutter_architecture/data/model/coin/coin.dart';
import 'package:retrofit/retrofit.dart';

part 'coins_api.g.dart';

@RestApi()
abstract class CoinsApi {
  factory CoinsApi(Dio dio, {String? baseUrl}) = _CoinsApi;

  @GET("exchanges/")
  Future<List<Coin>> getCoins();

  @GET("exchanges/{id}/")
  Future<Coin> getCoinById(@Path("id") int id);
}
