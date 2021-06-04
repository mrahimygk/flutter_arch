import 'package:json_annotation/json_annotation.dart';

part 'exchange_rate.g.dart';

@JsonSerializable()
class ExchangeRate {
  @JsonKey(name: 'time')
  final String time;
  @JsonKey(name: 'asset_id_quote')
  final String coinId;
  @JsonKey(name: 'rate')
  final double rate;

  ExchangeRate(
    this.time,
    this.coinId,
    this.rate,
  );

  factory ExchangeRate.fromJson(Map<String, dynamic> json) => _$ExchangeRateFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangeRateToJson(this);
}