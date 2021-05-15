
import 'package:flutter_architecture/data/model/plant/plant.dart' as data;
import 'package:flutter_architecture/domain/model/plant/plant.dart' as domain;

extension ToDomain on data.Plant {
  domain.Plant toDomain() => domain.Plant(
    id,
    name,
    family,
    imageAddress
  );
}