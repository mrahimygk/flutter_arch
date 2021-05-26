import 'package:json_annotation/json_annotation.dart';

part 'coin_icon.g.dart';

@JsonSerializable()
class CoinIcon {
  @JsonKey(name: 'exchange_id')
  final String id;
  @JsonKey(name: 'url')
  final String url;

  CoinIcon(
    this.id,
    this.url,
  );

  factory CoinIcon.fromJson(Map<String, dynamic> json) =>
      _$CoinIconFromJson(json);

  Map<String, dynamic> toJson() => _$CoinIconToJson(this);
}
