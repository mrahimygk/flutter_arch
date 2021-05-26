import 'package:flutter_architecture/common/base/page_cubit.dart';
import 'package:flutter_architecture/common/base/page_state.dart';
import 'package:flutter_architecture/domain/model/base/api_resource.dart';
import 'package:flutter_architecture/domain/model/base/status.dart';
import 'package:flutter_architecture/domain/model/coin/coin.dart';
import 'package:flutter_architecture/domain/usecase/coin/get_coins_usecase.dart';

part 'coin_list_state.dart';

class CoinListCubit extends PageCubit<CoinListState> {
  final GetCoinsUseCase _getCoinsUseCase;

  CoinListCubit(this._getCoinsUseCase) : super(CoinListInitialState());

  void getCoinList() {
    _getCoinsUseCase.execute(null).listen((ApiResource<List<Coin>> event) {
      switch (event.status) {
        case Status.LOADING:
          emit(CoinListLoadingState());
          break;

        case Status.SUCCESS:
          if (event.data == null || (event.data?.isEmpty == true)) {
            emit(CoinListNoDataState());
          } else {
            emit(CoinListDataReceivedState(event.data!));
          }
          break;

        case Status.ERROR:
          emit(CoinListErrorState(event.message!));
      }
    }).onError((e, s) {
      emit(CoinListErrorState(e.toString()));
    });
  }
}
