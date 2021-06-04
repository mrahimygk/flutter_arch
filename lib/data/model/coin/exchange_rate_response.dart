import 'package:flutter_architecture/data/model/coin/exchange_rate.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exchange_rate_response.g.dart';

@JsonSerializable()
class ExchangeRateResponse {
  @JsonKey(name: 'asset_id_base')
  final String coinId;

  @JsonKey(name: 'rates')
  final List<ExchangeRate> rates;

  ExchangeRateResponse(
    this.coinId,
    this.rates,
  );

  factory ExchangeRateResponse.fromJson(Map<String, dynamic> json) =>
      _$ExchangeRateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangeRateResponseToJson(this);
}
