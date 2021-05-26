import 'package:json_annotation/json_annotation.dart';

part 'coin.g.dart';

@JsonSerializable()
class Coin {
  @JsonKey(name: 'exchange_id')
  final String id;
  @JsonKey(name: 'data_symbols_count')
  final int symbolsCount;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'website')
  final String website;
  @JsonKey(name: 'volume_1hrs_usd')
  final double hourlyVolume;
  @JsonKey(name: 'volume_1day_usd')
  final double dailyVolume;
  @JsonKey(name: 'volume_1mth_usd')
  final double monthlyVolume;

  Coin(
    this.id,
    this.symbolsCount,
    this.name,
    this.website,
    this.hourlyVolume,
    this.dailyVolume,
    this.monthlyVolume,
  );

  factory Coin.fromJson(Map<String, dynamic> json) => _$CoinFromJson(json);

  Map<String, dynamic> toJson() => _$CoinToJson(this);
}
