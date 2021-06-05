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

class CoinListDataFilledState extends CoinListState {
  final List<Coin> coins;

  CoinListDataFilledState(this.coins);

  @override
  List<Object?> get props => [coins];
}

class CoinListNavigationState extends CoinListState implements NavigationState {
  @override
  final String destination;
  @override
  final dynamic args;

  @override
  String? popUntil;

  @override
  NavigationType? navigationType;

  CoinListNavigationState(this.destination, this.args);

  @override
  List<Object> get props => [args, destination];
}