import 'package:json_annotation/json_annotation.dart';

part 'plant.g.dart';

@JsonSerializable()
class Plant {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'common_name')
  final String name;
  @JsonKey(name: 'family')
  final String family;
  @JsonKey(name: 'image_url')
  final String imageAddress;

  Plant(
    this.id,
    this.name,
    this.family,
    this.imageAddress,
  );

  factory Plant.fromJson(Map<String, dynamic> json) => _$PlantFromJson(json);
  Map<String, dynamic> toJson(Map<String, dynamic> json) => _$PlantToJson(this);
}
