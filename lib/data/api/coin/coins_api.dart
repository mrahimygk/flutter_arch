import 'package:dio/dio.dart';
import 'package:flutter_architecture/data/model/coin/coin.dart';
import 'package:flutter_architecture/data/model/coin/coin_icon.dart';
import 'package:retrofit/retrofit.dart';

part 'coins_api.g.dart';

@RestApi()
abstract class CoinsApi {
  factory CoinsApi(Dio dio, {String? baseUrl}) = _CoinsApi;

  @GET("exchanges/")
  Future<List<Coin>> getCoins();

  @GET("exchanges/icons/{iconSize}")
  Future<List<CoinIcon>> getCoinIcons({@Path("iconSize") int iconSize = 24});

  @GET("exchanges/{id}/")
  Future<Coin> getCoinById(@Path("id") int id);
}
