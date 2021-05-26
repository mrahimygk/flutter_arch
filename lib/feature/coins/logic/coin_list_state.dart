part of 'coin_list_cubit.dart';

abstract class CoinListState extends PageState {
  const CoinListState();
}

class CoinListInitialState extends CoinListState {
  @override
  List<Object?> get props => [];
}

class CoinListLoadingState extends CoinListState {
  @override
  List<Object?> get props => [];
}

class CoinListNoDataState extends CoinListState {
  @override
  List<Object?> get props => [];
}

class CoinListErrorState extends CoinListState {
  final String error;

  CoinListErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class CoinListDataReceivedState extends CoinListState {
  final List<Coin> coins;

  CoinListDataReceivedState(this.coins);

  @override
  List<Object?> get props => [coins];

}

//TODO: add navigate state to go to details