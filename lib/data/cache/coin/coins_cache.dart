import 'package:flutter_architecture/data/model/coin/coin.dart';
import 'package:flutter_architecture/data/model/coin/coin_icon.dart';
import 'package:retrofit/retrofit.dart';

abstract class CoinsCache {
  Future<List<Coin>>? getCoins();

  Future<List<CoinIcon>>? getCoinIcons({@Path("iconSize") int iconSize = 24});

  Future<List<Coin>>? getCoinById(@Path("id") String id);

  void putCoinIcons(List<CoinIcon> icons);

  void putCoin(Coin coin);

  void putCoins(List<Coin> coins);
}

class CoinsCacheImpl extends CoinsCache {
  Map<String, Coin>? exchanges;
  Map<String, CoinIcon>? exchangesIcons;

  @override
  Future<List<Coin>>? getCoins() =>
      exchanges == null ? null : Future.value(exchanges!.values.toList());

  @override
  Future<List<CoinIcon>>? getCoinIcons({@Path("iconSize") int iconSize = 24}) =>
      exchangesIcons == null
          ? null
          : Future.value(exchangesIcons!.values.toList());

  @override
  Future<List<Coin>>? getCoinById(@Path("id") String id) =>
      exchanges == null || exchanges![id] == null
          ? null
          : Future.value([exchanges![id]!]);

  @override
  void putCoin(Coin coin) {
    if (exchanges == null) {
      exchanges = Map<String, Coin>();
    }
    exchanges![coin.id] = coin;
  }

  void putCoins(List<Coin> coins) {
    if (exchanges == null) {
      exchanges = Map<String, Coin>();
    }
    coins.forEach((element) {
      exchanges![element.id] = element;
    });
  }

  void putCoinIcons(List<CoinIcon> icons) {
    if (exchangesIcons == null) {
      exchangesIcons = Map<String, CoinIcon>();
    }
    icons.forEach((element) {
      exchangesIcons![element.id] = element;
    });
  }
}
