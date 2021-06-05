import 'package:flutter_architecture/domain/base/base_use_case.dart';
import 'package:flutter_architecture/domain/model/base/api_resource.dart';
import 'package:flutter_architecture/domain/model/coin/rate_history.dart';
import 'package:flutter_architecture/domain/model/coin/rate_history_request.dart';
import 'package:flutter_architecture/repository/coins/exchange_rates_repository.dart';

abstract class GetRateHistoryUseCase
    extends BaseUseCase<RateHistoryRequest, List<RateHistory>> {
  final ExchangeRatesRepository _repository;

  GetRateHistoryUseCase(this._repository);
}

class GetRateHistoryUseCaseImpl extends GetRateHistoryUseCase {
  GetRateHistoryUseCaseImpl(ExchangeRatesRepository repository)
      : super(repository);

  @override
  Stream<ApiResource<List<RateHistory>>> execute(RateHistoryRequest request) =>
      _repository.getRateHistoryForTwoCoins(request);
}
