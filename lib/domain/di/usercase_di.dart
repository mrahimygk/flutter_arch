import 'package:flutter_architecture/di/di.dart';
import 'package:flutter_architecture/domain/repository/plants_repository.dart';
import 'package:flutter_architecture/domain/usecase/get_plants_usecase.dart';

void registerUseCaseModule() {
  serviceLocator.registerFactory<GetPlantsUseCase>(
      () => GetPlantsUseCaseImpl(serviceLocator.get<PlantsRepository>()));
}
