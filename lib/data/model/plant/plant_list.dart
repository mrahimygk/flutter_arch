import 'package:flutter_architecture/data/model/plant/plant.dart';
import 'package:json_annotation/json_annotation.dart';

part 'plant_list.g.dart';

@JsonSerializable()
class PlantList {
  @JsonKey(name: 'data')
  final List<Plant> plantList;

  PlantList(
    this.plantList,
  );

  factory PlantList.fromJson(Map<String, dynamic> json) => _$PlantListFromJson(json);
  Map<String, dynamic> toJson() => _$PlantListToJson(this);
}
