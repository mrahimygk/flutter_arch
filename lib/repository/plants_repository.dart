import 'package:flutter_architecture/common/transform/plants/plant_list.dart';
import 'package:flutter_architecture/data/api/plants_api.dart';
import 'package:flutter_architecture/data/model/plant/plant_list.dart';
import 'package:flutter_architecture/domain/model/base/api_resource.dart';
import 'package:flutter_architecture/domain/model/base/status.dart';
import 'package:flutter_architecture/domain/model/plant/plant.dart';
import 'package:dio/dio.dart';

abstract class PlantsRepository {
  final PlantsApi _plantsApi;

  PlantsRepository(this._plantsApi);

  Stream<ApiResource<List<Plant>>> getPlants();

  Stream<ApiResource<Plant>> getPlantById(String id);
}

class PlantsRepositoryImpl extends PlantsRepository {
  PlantsRepositoryImpl(PlantsApi plantsApi) : super(plantsApi);

  @override
  Stream<ApiResource<List<Plant>>> getPlants() async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<List<Plant>> data =
        await _plantsApi.getPlants().then((PlantList value) {
      return ApiResource(Status.SUCCESS, value.toDomain(), null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, (error as DioError).message);
    });

    yield data;
  }

  @override
  Stream<ApiResource<Plant>> getPlantById(String id) async* {
    yield ApiResource(Status.LOADING, null, null);

    throw UnimplementedError();
  }
}
