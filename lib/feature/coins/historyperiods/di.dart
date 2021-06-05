import 'package:flutter_architecture/app/di.dart';
import 'package:flutter_architecture/domain/usecase/coin/get_history_periods_usecase.dart';
import 'package:flutter_architecture/feature/coins/historyperiods/logic/history_periods_cubit.dart';

void registerHistoryPeriodsWidget() {
  serviceLocator.registerFactory<HistoryPeriodsCubit>(() => HistoryPeriodsCubit(
        serviceLocator.get<GetHistoryPeriodsUseCase>(),
      ));
}
