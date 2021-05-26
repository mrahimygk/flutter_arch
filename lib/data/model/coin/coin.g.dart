// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coin _$CoinFromJson(Map<String, dynamic> json) {
  return Coin(
    json['exchange_id'] as String,
    json['data_symbols_count'] as int,
    json['name'] as String,
    json['website'] as String,
    (json['volume_1hrs_usd'] as num).toDouble(),
    (json['volume_1day_usd'] as num).toDouble(),
    (json['volume_1mth_usd'] as num).toDouble(),
  );
}

Map<String, dynamic> _$CoinToJson(Coin instance) => <String, dynamic>{
      'exchange_id': instance.id,
      'data_symbols_count': instance.symbolsCount,
      'name': instance.name,
      'website': instance.website,
      'volume_1hrs_usd': instance.hourlyVolume,
      'volume_1day_usd': instance.dailyVolume,
      'volume_1mth_usd': instance.monthlyVolume,
    };
