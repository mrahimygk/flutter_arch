import 'package:flutter_architecture/di.dart';
import 'package:flutter_architecture/domain/usecase/get_plant_list_usecase.dart';
import 'package:flutter_architecture/repository/plants_repository.dart';

void registerUseCaseModule() {
  serviceLocator.registerFactory<GetPlantListUseCase>(
      () => GetPlantsUseCaseImpl(serviceLocator.get<PlantsRepository>()));
}
