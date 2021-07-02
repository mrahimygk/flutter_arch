import 'package:flutter_architecture/data/model/coin/coin.dart';
import 'package:flutter_architecture/data/model/coin/coin_icon.dart';
import 'package:retrofit/retrofit.dart';

abstract class CoinsCache {
  Future<List<Coin>> getCoins();

  Future<List<CoinIcon>> getCoinIcons({@Path("iconSize") int iconSize = 24});

  Future<List<Coin>> getCoinById(@Path("id") String id);
}

class CoinsCacheImpl {
  final exchanges = Map<String, Coin>();
  final exchangesIcons = Map<String, CoinIcon>();

  Future<List<Coin>> getCoins() => Future.value(exchanges.values.toList());

  Future<List<CoinIcon>> getCoinIcons({@Path("iconSize") int iconSize = 24}) =>
      Future.value(exchangesIcons.values.toList());

  Future<List<Coin>> getCoinById(@Path("id") String id) =>
      Future.value([exchanges[id]!]);

  void putCoin(Coin coin) {
    exchanges[coin.id] = coin;
  }

  void putCoins(List<Coin> coins) {
    coins.forEach((element) {
      exchanges[element.id] = element;
    });
  }
}
