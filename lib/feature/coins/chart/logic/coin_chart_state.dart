part of 'coin_chart_cubit.dart';

abstract class CoinChartState extends PageState {
  const CoinChartState();
}

class CoinChartInitialState extends CoinChartState {
  @override
  List<Object?> get props => [];
}

class CoinChartLoadingState extends CoinChartState {
  @override
  List<Object?> get props => [];
}

class CoinChartNoDataState extends CoinChartState {
  @override
  List<Object?> get props => [];
}

class CoinChartErrorState extends CoinChartState {
  final String error;

  CoinChartErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class CoinChartDataReceivedState extends CoinChartState {
  final List<RateHistory> rates;

  CoinChartDataReceivedState(this.rates);

  @override
  List<Object?> get props => [rates];
}

class CoinChartNavigationState extends CoinChartState
    implements NavigationState {
  @override
  final String destination;
  @override
  final dynamic args;

  @override
  String? popUntil;

  @override
  NavigationType? navigationType;

  CoinChartNavigationState(this.destination, this.args);

  @override
  List<Object> get props => [args, destination];
}