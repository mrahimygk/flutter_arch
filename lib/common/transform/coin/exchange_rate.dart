import 'package:flutter_architecture/data/model/coin/exchange_rate.dart'
    as data;
import 'package:flutter_architecture/domain/model/coin/exchange_rate.dart'
    as domain;

extension ToDomain on data.ExchangeRate {
  domain.ExchangeRate toDomain() => domain.ExchangeRate(
        time,
        coinId,
        rate,
      );
}
