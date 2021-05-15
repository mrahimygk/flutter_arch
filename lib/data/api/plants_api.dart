import 'package:flutter_architecture/data/model/plant/plant.dart';
import 'package:flutter_architecture/data/model/plant/plant_list.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'plants_api.g.dart';

@RestApi()
abstract class PlantsApi {
  factory PlantsApi(Dio dio, {String? baseUrl}) = _PlantsApi;

  @GET("plants/")
  Future<PlantList> getPlants();

  @GET("plants/{id}/")
  Future<Plant> getPlantById(@Path("id") int id);
}
