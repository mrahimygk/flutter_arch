import 'package:flutter_architecture/di.dart';
import 'package:flutter_architecture/domain/usecase/coin/get_coin_icons_usecase.dart';
import 'package:flutter_architecture/domain/usecase/coin/get_coins_usecase.dart';

import 'logic/coin_list_cubit.dart';

void registerCoinListPage() {
  serviceLocator.registerFactory<CoinListCubit>(() => CoinListCubit(
        serviceLocator.get<GetCoinsUseCase>(),
        serviceLocator.get<GetCoinIconsUseCase>(),
      ));
}
