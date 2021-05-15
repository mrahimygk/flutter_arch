import 'package:flutter_architecture/domain/base/base_use_case.dart';
import 'package:flutter_architecture/domain/model/base/api_resource.dart';
import 'package:flutter_architecture/domain/model/plant/plant.dart';
import 'package:flutter_architecture/domain/repository/plants_repository.dart';

abstract class GetPlantsUseCase extends BaseUseCase<void, List<Plant>> {
  final PlantsRepository _plantsRepository;

  GetPlantsUseCase(this._plantsRepository);
}

class GetPlantsUseCaseImpl extends GetPlantsUseCase {
  GetPlantsUseCaseImpl(PlantsRepository plantsRepository)
      : super(plantsRepository);

  @override
  Stream<ApiResource<List<Plant>>> execute(void request) =>
      _plantsRepository.getPlants();
}
