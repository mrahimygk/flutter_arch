// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RateHistory _$RateHistoryFromJson(Map<String, dynamic> json) {
  return RateHistory(
    json['time_period_start'] as String,
    json['time_period_end'] as String,
    json['time_open'] as String,
    json['time_close'] as String,
    (json['rate_open'] as num).toDouble(),
    (json['rate_high'] as num).toDouble(),
    (json['rate_low'] as num).toDouble(),
    (json['rate_close'] as num).toDouble(),
  );
}

Map<String, dynamic> _$RateHistoryToJson(RateHistory instance) =>
    <String, dynamic>{
      'time_period_start': instance.startingDate,
      'time_period_end': instance.endingDate,
      'time_open': instance.openTime,
      'time_close': instance.closeTime,
      'rate_open': instance.openRate,
      'rate_high': instance.highRate,
      'rate_low': instance.lowRate,
      'rate_close': instance.closeRate,
    };
