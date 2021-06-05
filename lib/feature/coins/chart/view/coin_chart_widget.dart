import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/di.dart';
import 'package:flutter_architecture/common/base/base_page.dart';
import 'package:flutter_architecture/common/widgets/api_error_widget.dart';
import 'package:flutter_architecture/domain/model/coin/rate_history.dart';
import 'package:flutter_architecture/feature/coins/chart/logic/coin_chart_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoinChartWidget extends BasePage<CoinChartCubit, CoinChartState, void> {
  final CoinChartCubit _cubit = serviceLocator.get<CoinChartCubit>();

  CoinChartWidget({Key? key}) : super(key: key) {
    _cubit.getCoinChart();
  }

  @override
  Widget buildPageWidget(BuildContext context) {
    final TextDirection direction = Directionality.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder(
      bloc: _cubit,
      buildWhen: (previousState, currentState) {
        return previousState != currentState;
      },
      builder: (BuildContext context, CoinChartState state) {
        if (state is CoinChartInitialState ||
            state is CoinChartNavigationState) {
          return Container(color: Colors.white);
        }

        if (state is CoinChartLoadingState) {
          return Expanded(child: Center(child: CircularProgressIndicator()));
        }

        if (state is CoinChartNoDataState) {
          return Center(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ApiErrorWidget("No data, please retry", () {
                  _cubit.getCoinChart();
                })),
          );
        }

        if (state is CoinChartErrorState) {
          return Center(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ApiErrorWidget(state.error, () {
                  _cubit.getCoinChart();
                })),
          );
        }

        if (state is CoinChartDataReceivedState) {
          return Expanded(
              child: _buildCoinChartView(state.rates, direction, isDarkMode));
        }

        throw Exception("Please handle all states above $state");
      },
    );
  }

  @override
  CoinChartCubit getPageBloc() => _cubit;

  Widget _buildCoinChartView(
      List<RateHistory> items, TextDirection direction, bool isDarkMode) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                    ),
                    Flexible(
                        child: Text(
                      "${item.lowRate} (${item.highRate})",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(item.endingDate),
                ),
              ],
            ),
          );
        });
  }
}
