
import 'package:flutter_architecture/app/di.dart';
import 'package:flutter_architecture/domain/usecase/coin/get_rate_history_usecase.dart';
import 'package:flutter_architecture/feature/coins/chart/logic/coin_chart_cubit.dart';

void registerCoinChartPage(){
  serviceLocator.registerFactory<CoinChartCubit>(() => CoinChartCubit(
    serviceLocator.get<GetRateHistoryUseCase>()
  ));
}