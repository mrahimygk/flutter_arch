// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_rate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeRate _$ExchangeRateFromJson(Map<String, dynamic> json) {
  return ExchangeRate(
    json['time'] as String,
    json['asset_id_quote'] as String,
    (json['rate'] as num).toDouble(),
  );
}

Map<String, dynamic> _$ExchangeRateToJson(ExchangeRate instance) =>
    <String, dynamic>{
      'time': instance.time,
      'asset_id_quote': instance.coinId,
      'rate': instance.rate,
    };
