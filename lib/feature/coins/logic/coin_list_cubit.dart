import 'package:flutter_architecture/common/base/page_cubit.dart';
import 'package:flutter_architecture/common/base/page_state.dart';
import 'package:flutter_architecture/domain/model/base/api_resource.dart';
import 'package:flutter_architecture/domain/model/base/status.dart';
import 'package:flutter_architecture/domain/model/coin/coin.dart';
import 'package:flutter_architecture/domain/model/coin/coin_icon.dart';
import 'package:flutter_architecture/domain/usecase/coin/get_coins_usecase.dart';
import 'package:flutter_architecture/domain/usecase/coin/get_coin_icons_usecase.dart';
import 'package:flutter_architecture/navigation/routes.dart';
import 'package:flutter_architecture/navigation/type.dart';

part 'coin_list_state.dart';

class CoinListCubit extends PageCubit<CoinListState> {
  final GetCoinsUseCase _getCoinsUseCase;
  final GetCoinIconsUseCase _getCoinIconsUseCase;

  CoinListCubit(
    this._getCoinsUseCase,
    this._getCoinIconsUseCase,
  ) : super(CoinListInitialState());

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
            _getCoinIconsUseCase
                .execute(null)
                .listen((ApiResource<List<CoinIcon>> iconsEvent) {
              switch (iconsEvent.status) {
                case Status.LOADING:
                  break;
                case Status.ERROR:
                  break;
                case Status.SUCCESS:
                  final data = event.data?.map((Coin coin) {
                    final filteredList =
                        iconsEvent.data?.where((CoinIcon element) {
                      return element.id == coin.id;
                    }).toList();
                    final url = filteredList?.isEmpty == true
                        ? null
                        : filteredList?.first.url;
                    return coin.copyWith(url: url);
                  }).toList();
                  emit(CoinListDataFilledState(data!));
                  break;
              }
            });
          }
          break;

        case Status.ERROR:
          emit(CoinListErrorState(event.message!));
      }
    }).onError((e, s) {
      emit(CoinListErrorState(e.toString()));
    });
  }

  void navigateToCoinDetails(Coin coin){
    emit(CoinListNavigationState(NavigationRoutes.COIN_DETAILS, coin));
  }
}
