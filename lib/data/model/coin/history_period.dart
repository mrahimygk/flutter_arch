import 'package:json_annotation/json_annotation.dart';

part 'history_period.g.dart';

@JsonSerializable()
class HistoryPeriod {
  @JsonKey(name: 'period_id')
  final String periodId;
  @JsonKey(name: 'length_seconds')
  final int lengthBySeconds;
  @JsonKey(name: 'length_months')
  final int lengthByMonths;
  @JsonKey(name: 'unit_count')
  final int unitCount;
  @JsonKey(name: 'unit_name')
  final String unitName;
  @JsonKey(name: 'display_name')
  final String displayName;

  HistoryPeriod(
    this.periodId,
    this.lengthBySeconds,
    this.lengthByMonths,
    this.unitCount,
    this.unitName,
    this.displayName,
  );

  factory HistoryPeriod.fromJson(Map<String, dynamic> json) =>
      _$HistoryPeriodFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryPeriodToJson(this);
}
