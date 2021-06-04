import 'package:flutter_architecture/common/base/page_cubit.dart';
import 'package:flutter_architecture/common/base/page_state.dart';
import 'package:flutter_architecture/domain/model/base/api_resource.dart';
import 'package:flutter_architecture/domain/model/base/status.dart';
import 'package:flutter_architecture/domain/model/coin/exchange_rate.dart';
import 'package:flutter_architecture/domain/usecase/coin/get_coin_rates_usecase.dart';

part 'coin_exchange_rates_state.dart';

class CoinExchangeRatesCubit extends PageCubit<CoinExchangeRatesState> {
  final GetCoinRatesUseCase _getCoinRatesUseCase;

  CoinExchangeRatesCubit(
    this._getCoinRatesUseCase,
  ) : super(CoinExchangeRatesInitialState());

  void getCoinExchangeRates(String id) {
    _getCoinRatesUseCase.execute(id).listen((ApiResource<List<ExchangeRate>> event) {
      switch (event.status) {
        case Status.LOADING:
          emit(CoinExchangeRatesLoadingState());
          break;

        case Status.SUCCESS:
          if (event.data == null || event.data?.length == 0) {
            emit(CoinExchangeRatesNoDataState());
          } else {
            emit(CoinExchangeRatesDataReceivedState(event.data!));
          }
          break;

        case Status.ERROR:
          emit(CoinExchangeRatesErrorState(event.message!));
      }
    }).onError((e, s) {
      emit(CoinExchangeRatesErrorState(e.toString()));
    });
  }
}
