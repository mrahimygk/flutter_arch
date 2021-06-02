import 'package:flutter_architecture/common/base/page_cubit.dart';
import 'package:flutter_architecture/common/base/page_state.dart';
import 'package:flutter_architecture/domain/model/base/api_resource.dart';
import 'package:flutter_architecture/domain/model/base/status.dart';
import 'package:flutter_architecture/domain/model/coin/coin.dart';
import 'package:flutter_architecture/domain/usecase/coin/get_coin_by_id_usecase.dart';

part 'coin_details_state.dart';

class CoinDetailsCubit extends PageCubit<CoinDetailsState> {
  final GetCoinByIdUseCase _getCoinByIdUseCase;

  CoinDetailsCubit(
    this._getCoinByIdUseCase,
  ) : super(CoinDetailsInitialState());

  void getCoinDetails(String id) {
    _getCoinByIdUseCase.execute(id).listen((ApiResource<Coin> event) {
      switch (event.status) {
        case Status.LOADING:
          emit(CoinDetailsLoadingState());
          break;

        case Status.SUCCESS:
          if (event.data == null) {
            emit(CoinDetailsNoDataState());
          } else {
            emit(CoinDetailsDataReceivedState(event.data!));
          }
          break;

        case Status.ERROR:
          emit(CoinDetailsErrorState(event.message!));
      }
    }).onError((e, s) {
      emit(CoinDetailsErrorState(e.toString()));
    });
  }
}
