import 'package:flutter_architecture/domain/base/base_use_case.dart';
import 'package:flutter_architecture/domain/model/base/api_resource.dart';
import 'package:flutter_architecture/domain/model/coin/coin_icon.dart';
import 'package:flutter_architecture/repository/coins/coins_repository.dart';

abstract class GetCoinIconsUseCase extends BaseUseCase<void, List<CoinIcon>> {
  final CoinsRepository _repository;

  GetCoinIconsUseCase(this._repository);
}

class GetCoinIconsUseCaseImpl extends GetCoinIconsUseCase {
  GetCoinIconsUseCaseImpl(CoinsRepository repository) : super(repository);

  @override
  Stream<ApiResource<List<CoinIcon>>> execute(void request) =>
      _repository.getCoinIcons();
}
