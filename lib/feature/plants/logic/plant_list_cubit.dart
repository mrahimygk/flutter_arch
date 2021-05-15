import 'package:flutter_architecture/common/base/page_cubit.dart';
import 'package:flutter_architecture/common/base/page_state.dart';
import 'package:flutter_architecture/domain/model/base/api_resource.dart';
import 'package:flutter_architecture/domain/model/base/status.dart';
import 'package:flutter_architecture/domain/model/plant/plant.dart';
import 'package:flutter_architecture/domain/usecase/get_plant_list_usecase.dart';

part 'plant_list_state.dart';

class PlantListCubit extends PageCubit<PlantListState> {
  final GetPlantListUseCase _getPlantListUseCase;

  PlantListCubit(this._getPlantListUseCase) : super(PlantListInitialState());

  void getPlantList() {
    _getPlantListUseCase.execute(null).listen((ApiResource<List<Plant>> event) {
      switch (event.status) {
        case Status.LOADING:
          emit(PlantListLoadingState());
          break;

        case Status.SUCCESS:
          if (event.data == null || (event.data?.isEmpty == true)) {
            emit(PlantListNoDataState());
          } else {
            emit(PlantListDataReceivedState(event.data!));
          }
          break;

        case Status.ERROR:
          emit(PlantListErrorState());
      }
    }).onError((e, s) {
      emit(PlantListErrorState());
    });
  }
}
