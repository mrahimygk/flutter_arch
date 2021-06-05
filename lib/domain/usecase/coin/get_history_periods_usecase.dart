import 'package:flutter_architecture/domain/base/base_use_case.dart';
import 'package:flutter_architecture/domain/model/base/api_resource.dart';
import 'package:flutter_architecture/domain/model/coin/history_period.dart';
import 'package:flutter_architecture/repository/coins/exchange_rates_repository.dart';

abstract class GetHistoryPeriodsUseCase
    extends BaseUseCase<void, List<HistoryPeriod>> {
  final ExchangeRatesRepository _repository;

  GetHistoryPeriodsUseCase(this._repository);
}

class GetHistoryPeriodsUseCaseImpl extends GetHistoryPeriodsUseCase {
  GetHistoryPeriodsUseCaseImpl(ExchangeRatesRepository repository)
      : super(repository);

  @override
  Stream<ApiResource<List<HistoryPeriod>>> execute(void r) =>
      _repository.getHistoryPeriods();
}
