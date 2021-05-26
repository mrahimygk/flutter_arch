import 'package:flutter_architecture/data/model/coin/coin_icon.dart' as data;
import 'package:flutter_architecture/domain/model/coin/coin_icon.dart'
    as domain;

extension ToDomain on data.CoinIcon {
  domain.CoinIcon toDomain() => domain.CoinIcon(
        id,
        url,
      );
}
