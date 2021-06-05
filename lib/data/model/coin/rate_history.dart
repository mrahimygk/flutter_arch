import 'package:json_annotation/json_annotation.dart';

part 'rate_history.g.dart';

@JsonSerializable()
class RateHistory {
  @JsonKey(name: 'time_period_start')
  final String startingDate;
  @JsonKey(name: 'time_period_end')
  final String endingDate;
  @JsonKey(name: 'time_open')
  final String openTime;
  @JsonKey(name: 'time_close')
  final String closeTime;

  @JsonKey(name: 'rate_open')
  final double openRate;
  @JsonKey(name: 'rate_high')
  final double highRate;
  @JsonKey(name: 'rate_low')
  final double lowRate;
  @JsonKey(name: 'rate_close')
  final double closeRate;

  RateHistory(
    this.startingDate,
    this.endingDate,
    this.openTime,
    this.closeTime,
    this.openRate,
    this.highRate,
    this.lowRate,
    this.closeRate,
  );

  factory RateHistory.fromJson(Map<String, dynamic> json) =>
      _$RateHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$RateHistoryToJson(this);
}
