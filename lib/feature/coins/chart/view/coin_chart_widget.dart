import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/di.dart';
import 'package:flutter_architecture/common/base/base_page.dart';
import 'package:flutter_architecture/common/ext/iterable.dart';
import 'package:flutter_architecture/common/widgets/api_error_widget.dart';
import 'package:flutter_architecture/domain/model/coin/rate_history.dart';
import 'package:flutter_architecture/domain/model/coin/rate_history_request.dart';
import 'package:flutter_architecture/feature/coins/chart/logic/coin_chart_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoinChartWidget extends BasePage<CoinChartCubit, CoinChartState, void> {
  final CoinChartCubit _cubit = serviceLocator.get<CoinChartCubit>();
  final RateHistoryRequest rateHistoryRequest;

  CoinChartWidget(this.rateHistoryRequest, {Key? key}) : super(key: key);

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
      builder: (BuildContext context, CoinChartState state) {
        if (state is CoinChartInitialState ||
            state is CoinChartNavigationState) {
          return Container(color: Colors.white);
        }

        if (state is CoinChartLoadingState) {
          return Center(child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: CircularProgressIndicator(),
          ));
        }

        if (state is CoinChartNoDataState) {
          return Center(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ApiErrorWidget("No data, please retry", () {
                  _cubit.getCoinChart(rateHistoryRequest);
                })),
          );
        }

        if (state is CoinChartErrorState) {
          return Center(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ApiErrorWidget(state.error, () {
                  _cubit.getCoinChart(rateHistoryRequest);
                })),
          );
        }

        if (state is CoinChartDataReceivedState) {
          return _buildCoinChartView(state.rates, direction, isDarkMode);
        }

        throw Exception("Please handle all states above $state");
      },
    );
  }

  @override
  CoinChartCubit getPageBloc() => _cubit;

  Widget _buildCoinChartView(
      List<RateHistory> items, TextDirection direction, bool isDarkMode) {
    final Color leftBarColor = const Color(0xff53fdd7);
    final Color rightBarColor = const Color(0xffff5182);
    final double width = 7;
    final double maxY =
        items.maxBy((RateHistory element) => element.openRate)!.openRate;

    late List<BarChartGroupData> barGroups =
        items.mapIndexed((int index, RateHistory e) {
      return BarChartGroupData(barsSpace: 4, x: index, barRods: [
        BarChartRodData(
          y: e.lowRate,
          colors: [leftBarColor],
          width: width,
        ),
        BarChartRodData(
          y: e.highRate,
          colors: [rightBarColor],
          width: width,
        ),
      ]);
    }).take(12).toList();

    return AspectRatio(
      aspectRatio: 1.33,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: const Color(0xff2c4260),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${rateHistoryRequest.baseId} / ${rateHistoryRequest.quoteId}",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'exchangeRates',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: BarChart(
                    BarChartData(
                      maxY: maxY,
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: SideTitles(
                          reservedSize: 18,
                          rotateAngle: 90,
                          showTitles: true,
                          getTextStyles: (value) => const TextStyle(
                            color: Color(0xff7589a2),
                            fontSize: 14,
                          ),
                          margin: 8,
                          getTitles: (double value) {
                            return items[value.toInt()].startingDate.substring(0, 10);
                          },
                        ),
                        leftTitles: SideTitles(
                          showTitles: true,
                          getTextStyles: (value) => const TextStyle(
                            color: Color(0xff7589a2),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          margin: 16,
                          reservedSize: 14,
                          getTitles: (value) {
                            /*if(value == maxY) {
                              return  value.toInt().toString();
                            } else */if(value % 90 == 0){
                              return  value.toInt().toString();
                            } else return '';
                          },
                        ),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: barGroups,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 42,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void fetchData() => _cubit.getCoinChart(rateHistoryRequest);
}
