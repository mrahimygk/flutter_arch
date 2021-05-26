// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_icon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoinIcon _$CoinIconFromJson(Map<String, dynamic> json) {
  return CoinIcon(
    json['exchange_id'] as String,
    json['url'] as String,
  );
}

Map<String, dynamic> _$CoinIconToJson(CoinIcon instance) => <String, dynamic>{
      'exchange_id': instance.id,
      'url': instance.url,
    };
