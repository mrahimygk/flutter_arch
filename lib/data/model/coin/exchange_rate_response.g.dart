// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_rate_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeRateResponse _$ExchangeRateResponseFromJson(Map<String, dynamic> json) {
  return ExchangeRateResponse(
    json['asset_id_base'] as String,
    (json['rates'] as List<dynamic>)
        .map((e) => ExchangeRate.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ExchangeRateResponseToJson(
        ExchangeRateResponse instance) =>
    <String, dynamic>{
      'asset_id_base': instance.coinId,
      'rates': instance.rates,
    };
