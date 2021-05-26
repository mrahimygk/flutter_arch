import 'package:flutter_architecture/domain/base/base_use_case.dart';
import 'package:flutter_architecture/domain/model/base/api_resource.dart';
import 'package:flutter_architecture/domain/model/coin/coin.dart';
import 'package:flutter_architecture/repository/coins/coins_repository.dart';

abstract class GetCoinsUseCase extends BaseUseCase<void, List<Coin>> {
  final CoinsRepository _repository;

  GetCoinsUseCase(this._repository);
}

class GetCoinsUseCaseImpl extends GetCoinsUseCase {
  GetCoinsUseCaseImpl(CoinsRepository repository) : super(repository);

  @override
  Stream<ApiResource<List<Coin>>> execute(void request) =>
      _repository.getCoins();
}
