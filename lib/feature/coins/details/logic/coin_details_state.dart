part of 'coin_details_cubit.dart';

abstract class CoinDetailsState extends PageState {
  const CoinDetailsState();
}

class CoinDetailsInitialState extends CoinDetailsState {
  @override
  List<Object?> get props => [];
}

class CoinDetailsLoadingState extends CoinDetailsState {
  @override
  List<Object?> get props => [];
}

class CoinDetailsNoDataState extends CoinDetailsState {
  @override
  List<Object?> get props => [];
}

class CoinDetailsErrorState extends CoinDetailsState {
  final String error;

  CoinDetailsErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class CoinDetailsDataReceivedState extends CoinDetailsState {
  final Coin coin;

  CoinDetailsDataReceivedState(this.coin);

  @override
  List<Object?> get props => [coin];
}