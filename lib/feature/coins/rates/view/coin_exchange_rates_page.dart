import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/di.dart';
import 'package:flutter_architecture/common/base/base_page.dart';
import 'package:flutter_architecture/common/widgets/api_error_widget.dart';
import 'package:flutter_architecture/domain/model/coin/coin.dart';
import 'package:flutter_architecture/domain/model/coin/exchange_rate.dart';
import 'package:flutter_architecture/feature/coins/rates/logic/coin_exchange_rates_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoinExchangeRatesPage extends BasePage<CoinExchangeRatesCubit,
    CoinExchangeRatesState, Coin> {
  final CoinExchangeRatesCubit _cubit =
      serviceLocator.get<CoinExchangeRatesCubit>();

  final Coin coin;

  CoinExchangeRatesPage(this.coin, {Key? key}) : super(key: key) {
    _cubit.getCoinExchangeRates(coin.id);
  }

  @override
  Widget buildPageWidget(BuildContext context) {
    final TextDirection direction = Directionality.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          BlocBuilder(
            bloc: _cubit,
            buildWhen: (previousState, currentState) {
              return previousState != currentState;
            },
            builder: (BuildContext context, CoinExchangeRatesState state) {
              if (state is CoinExchangeRatesInitialState) {
                return Container(color: Colors.white);
              }

              if (state is CoinExchangeRatesLoadingState) {
                return Expanded(
                    child: Center(child: CircularProgressIndicator()));
              }

              if (state is CoinExchangeRatesNoDataState) {
                return Center(
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ApiErrorWidget("No rates data, you can retry", () {
                        _cubit.getCoinExchangeRates(coin.id);
                      })),
                );
              }

              if (state is CoinExchangeRatesErrorState) {
                return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ApiErrorWidget(state.error, () {
                      _cubit.getCoinExchangeRates(coin.id);
                    }));
              }

              if (state is CoinExchangeRatesDataReceivedState) {
                return Expanded(
                    child: _buildCoinExchangeRatesView(
                        state.exchangeRates, direction, isDarkMode));
              }

              throw Exception(
                  "Please handle all states above, unknown state $state");
            },
          ),
        ],
    );
  }

  @override
  CoinExchangeRatesCubit getPageBloc() => _cubit;

  Widget _buildCoinExchangeRatesView(
    List<ExchangeRate> exchangeRates,
    TextDirection direction,
    bool isDarkMode,
  ) {

    return ListView.builder(
      itemCount: exchangeRates.length,
        itemBuilder: (BuildContext context, index) {
      return Text(exchangeRates[index].coinId);
    });
  }
}
