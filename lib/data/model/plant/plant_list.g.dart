// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlantList _$PlantListFromJson(Map<String, dynamic> json) {
  return PlantList(
    (json['data'] as List<dynamic>)
        .map((e) => Plant.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$PlantListToJson(PlantList instance) => <String, dynamic>{
      'data': instance.plantList,
    };
