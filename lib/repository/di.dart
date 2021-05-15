import 'package:flutter_architecture/di.dart';
import 'package:flutter_architecture/repository/plants_repository.dart';
import 'package:flutter_architecture/data/api/plants_api.dart';

void registerRepositoryModule() {
  serviceLocator.registerFactory<PlantsRepository>(
      () => PlantsRepositoryImpl(serviceLocator.get<PlantsApi>()));
}
