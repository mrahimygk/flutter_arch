import 'package:flutter_architecture/common/base/page_cubit.dart';
import 'package:flutter_architecture/common/base/page_state.dart';
import 'package:flutter_architecture/domain/model/base/api_resource.dart';
import 'package:flutter_architecture/domain/model/base/status.dart';
import 'package:flutter_architecture/domain/model/coin/coin.dart';
import 'package:flutter_architecture/domain/model/coin/rate_history.dart';
import 'package:flutter_architecture/domain/model/coin/rate_history_request.dart';
import 'package:flutter_architecture/domain/usecase/coin/get_rate_history_usecase.dart';
import 'package:flutter_architecture/navigation/routes.dart';
import 'package:flutter_architecture/navigation/type.dart';

part 'coin_chart_state.dart';

class CoinChartCubit extends PageCubit<CoinChartState> {
  final GetRateHistoryUseCase _getRateHistoryUseCase;

  CoinChartCubit(
    this._getRateHistoryUseCase,
  ) : super(CoinChartInitialState());

  void getCoinChart() {
    _getRateHistoryUseCase
        .execute(RateHistoryRequest(
            "BTC", "USD", "1DAY", "2016-01-01T00:00:00", null))
        .listen((ApiResource<List<RateHistory>> event) {
      switch (event.status) {
        case Status.LOADING:
          emit(CoinChartLoadingState());
          break;

        case Status.SUCCESS:
          if (event.data == null || (event.data?.isEmpty == true)) {
            emit(CoinChartNoDataState());
          } else {
            emit(CoinChartDataReceivedState(event.data!));
          }
          break;

        case Status.ERROR:
          emit(CoinChartErrorState(event.message!));
      }
    }).onError((e, s) {
      emit(CoinChartErrorState(e.toString()));
    });
  }

  void navigateToCoinDetails(Coin coin) {
    emit(CoinChartNavigationState(NavigationRoutes.COIN_DETAILS, coin));
  }
}
