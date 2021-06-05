import 'package:flutter_architecture/common/base/page_cubit.dart';
import 'package:flutter_architecture/common/base/page_state.dart';
import 'package:flutter_architecture/domain/model/base/api_resource.dart';
import 'package:flutter_architecture/domain/model/base/status.dart';
import 'package:flutter_architecture/domain/model/coin/history_period.dart';
import 'package:flutter_architecture/domain/usecase/coin/get_history_periods_usecase.dart';

part 'history_periods_state.dart';

class HistoryPeriodsCubit extends PageCubit<HistoryPeriodsState> {
  final GetHistoryPeriodsUseCase _getHistoryPeriodsUseCase;

  HistoryPeriodsCubit(
    this._getHistoryPeriodsUseCase,
  ) : super(HistoryPeriodsInitialState());

  void getHistoryPeriods() {
    _getHistoryPeriodsUseCase
        .execute(null)
        .listen((ApiResource<List<HistoryPeriod>> event) {
      switch (event.status) {
        case Status.LOADING:
          emit(HistoryPeriodsLoadingState());
          break;

        case Status.SUCCESS:
          if (event.data == null || (event.data?.isEmpty == true)) {
            emit(HistoryPeriodsNoDataState());
          } else {
            emit(HistoryPeriodsDataReceivedState(event.data!));
          }
          break;

        case Status.ERROR:
          emit(HistoryPeriodsErrorState(event.message!));
      }
    }).onError((e, s) {
      emit(HistoryPeriodsErrorState(e.toString()));
    });
  }
}
