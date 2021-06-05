import 'package:flutter_architecture/app/di.dart';
import 'package:flutter_architecture/domain/usecase/coin/get_coin_rates_usecase.dart';
import 'package:flutter_architecture/feature/coins/rates/logic/coin_exchange_rates_cubit.dart';

void registerExchangeRatesPage() {
  serviceLocator
      .registerFactory<CoinExchangeRatesCubit>(() => CoinExchangeRatesCubit(
            serviceLocator.get<GetCoinRatesUseCase>(),
          ));
}
