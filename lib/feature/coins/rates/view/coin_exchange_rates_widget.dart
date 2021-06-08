import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/di.dart';
import 'package:flutter_architecture/common/base/base_page.dart';
import 'package:flutter_architecture/common/widgets/api_error_widget.dart';
import 'package:flutter_architecture/common/widgets/reveal_card_widget.dart';
import 'package:flutter_architecture/domain/model/coin/coin.dart';
import 'package:flutter_architecture/domain/model/coin/exchange_rate.dart';
import 'package:flutter_architecture/domain/model/coin/rate_history_request.dart';
import 'package:flutter_architecture/feature/coins/chart/view/coin_chart_widget.dart';
import 'package:flutter_architecture/feature/coins/rates/logic/coin_exchange_rates_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoinExchangeRatesWidget
    extends BasePage<CoinExchangeRatesCubit, CoinExchangeRatesState, Coin> {
  final CoinExchangeRatesCubit _cubit =
      serviceLocator.get<CoinExchangeRatesCubit>();

  final Coin coin;

  CoinExchangeRatesWidget(this.coin, {Key? key}) : super(key: key) {
    _cubit.getCoinExchangeRates(coin.id);
  }

  @override
  Widget buildWidget(
    BuildContext context,
    TextDirection direction,
    bool isDarkMode,
  ) {
    return BlocBuilder(
      bloc: _cubit,
      buildWhen: (previousState, currentState) {
        return previousState != currentState;
      },
      builder: (BuildContext context, CoinExchangeRatesState state) {
        if (state is CoinExchangeRatesInitialState) {
          return Container(color: Colors.white);
        }

        if (state is CoinExchangeRatesLoadingState) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is CoinExchangeRatesNoDataState) {
          return Center(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ApiErrorWidget("No rates data, you can retry", () {
                  _cubit.getCoinExchangeRates("BTC");
                })),
          );
        }

        if (state is CoinExchangeRatesErrorState) {
          return Center(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ApiErrorWidget(state.error, () {
                  _cubit.getCoinExchangeRates("BTC");
                })),
          );
        }

        if (state is CoinExchangeRatesDataReceivedState) {
          return _buildCoinExchangeRatesView(
              state.exchangeRates, direction, isDarkMode);
        }

        throw Exception(
            "Please handle all states above, unknown state $state");
      },
    );
  }

  @override
  CoinExchangeRatesCubit getPageBloc() => _cubit;

  Widget _buildCoinExchangeRatesView(
    List<ExchangeRate> exchangeRates,
    TextDirection direction,
    bool isDarkMode,
  ) {
    final List<GlobalKey<RevealAnimatedCardState>> keys = [];
    exchangeRates.forEach((element) {
      keys.add(GlobalKey<RevealAnimatedCardState>());
    });

    return ListView.builder(
        itemCount: exchangeRates.length,
        itemBuilder: (BuildContext context, index) {
          final item = exchangeRates[index];
          final key = keys[index];
          return RevealAnimatedCardWidget(
            key: key,
            innerWidget: Center(child: Text("inner ${item.coinId}")),
            outerWidget: Center(child: Text(item.coinId)),
            onHide: () {
              print("hiding");
            },
            onReveal: () {
              keys.forEach((element) {
                if (keys[index] != element &&
                    element.currentState != null &&
                    element.currentState!.isRevealed()) {
                  element.currentState?.toggleReveal();
                }
              });
            },
          );
        });
  }
}
