// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plant _$PlantFromJson(Map<String, dynamic> json) {
  return Plant(
    json['id'] as String,
    json['common_name'] as String,
    json['family'] as String,
    json['image_url'] as String,
  );
}

Map<String, dynamic> _$PlantToJson(Plant instance) => <String, dynamic>{
      'id': instance.id,
      'common_name': instance.name,
      'family': instance.family,
      'image_url': instance.imageAddress,
    };
