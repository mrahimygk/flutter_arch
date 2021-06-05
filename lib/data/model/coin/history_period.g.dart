// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_period.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryPeriod _$HistoryPeriodFromJson(Map<String, dynamic> json) {
  return HistoryPeriod(
    json['period_id'] as String,
    json['length_seconds'] as int,
    json['length_months'] as int,
    json['unit_count'] as int,
    json['unit_name'] as String,
    json['display_name'] as String,
  );
}

Map<String, dynamic> _$HistoryPeriodToJson(HistoryPeriod instance) =>
    <String, dynamic>{
      'period_id': instance.periodId,
      'length_seconds': instance.lengthBySeconds,
      'length_months': instance.lengthByMonths,
      'unit_count': instance.unitCount,
      'unit_name': instance.unitName,
      'display_name': instance.displayName,
    };
