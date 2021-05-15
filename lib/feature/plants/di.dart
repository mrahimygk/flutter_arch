import 'package:flutter_architecture/di.dart';
import 'package:flutter_architecture/domain/usecase/get_plant_list_usecase.dart';
import 'package:flutter_architecture/feature/plants/logic/plant_list_cubit.dart';

void registerPlantListPage() {
  serviceLocator.registerFactory<PlantListCubit>(
      () => PlantListCubit(serviceLocator.get<GetPlantListUseCase>()));
}