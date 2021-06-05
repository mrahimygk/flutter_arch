part of 'coin_exchange_rates_cubit.dart';

abstract class CoinExchangeRatesState extends PageState {
  const CoinExchangeRatesState();
}

class CoinExchangeRatesInitialState extends CoinExchangeRatesState {
  @override
  List<Object?> get props => [];
}

class CoinExchangeRatesLoadingState extends CoinExchangeRatesState {
  @override
  List<Object?> get props => [];
}

class CoinExchangeRatesNoDataState extends CoinExchangeRatesState {
  @override
  List<Object?> get props => [];
}

class CoinExchangeRatesErrorState extends CoinExchangeRatesState {
  final String error;

  CoinExchangeRatesErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class CoinExchangeRatesDataReceivedState extends CoinExchangeRatesState {
  final List<ExchangeRate> exchangeRates;

  CoinExchangeRatesDataReceivedState(this.exchangeRates);

  @override
  List<Object?> get props => [exchangeRates];
}