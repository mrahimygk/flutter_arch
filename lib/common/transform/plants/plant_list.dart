import 'package:flutter_architecture/common/transform/plants/plant.dart';
import 'package:flutter_architecture/data/model/plant/plant.dart' as data;
import 'package:flutter_architecture/data/model/plant/plant_list.dart';
import 'package:flutter_architecture/domain/model/plant/plant.dart' as domain;

extension ToDomain on PlantList {
  List<domain.Plant> toDomain() =>
      this.plantList.map((data.Plant e) => e.toDomain()).toList();
}
