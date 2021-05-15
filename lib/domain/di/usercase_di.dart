import 'package:flutter_architecture/di/di.dart';
import 'package:flutter_architecture/domain/repository/plants_repository.dart';
import 'package:flutter_architecture/domain/usecase/get_plant_list_usecase.dart';

void registerUseCaseModule() {
  serviceLocator.registerFactory<GetPlantListUseCase>(
      () => GetPlantsUseCaseImpl(serviceLocator.get<PlantsRepository>()));
}
