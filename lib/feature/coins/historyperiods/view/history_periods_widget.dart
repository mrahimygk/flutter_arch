import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/di.dart';
import 'package:flutter_architecture/common/base/base_page.dart';
import 'package:flutter_architecture/common/widgets/api_error_widget.dart';
import 'package:flutter_architecture/domain/model/coin/history_period.dart';
import 'package:flutter_architecture/feature/coins/historyperiods/logic/history_periods_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPeriodsWidget
    extends BasePage<HistoryPeriodsCubit, HistoryPeriodsState, void> {
  final HistoryPeriodsCubit _cubit = serviceLocator.get<HistoryPeriodsCubit>();

  HistoryPeriodsWidget({Key? key}) : super(key: key) {
    _cubit.getHistoryPeriods();
  }

  @override
  Widget buildWidget(
    BuildContext context,
    TextDirection direction,
    bool isDarkMode,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        BlocBuilder(
          bloc: _cubit,
          buildWhen: (previousState, currentState) {
            return previousState != currentState;
          },
          builder: (BuildContext context, HistoryPeriodsState state) {
            if (state is HistoryPeriodsInitialState) {
              return Container(color: Colors.white);
            }

            if (state is HistoryPeriodsLoadingState) {
              return Expanded(
                  child: Center(child: CircularProgressIndicator()));
            }

            if (state is HistoryPeriodsNoDataState) {
              return Text("No data, retry");
            }

            if (state is HistoryPeriodsErrorState) {
              return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ApiErrorWidget(state.error, () {
                    _cubit.getHistoryPeriods();
                  }));
            }

            if (state is HistoryPeriodsDataReceivedState) {
              return Expanded(
                  child: _buildHistoryPeriodsView(
                      state.periods, direction, isDarkMode));
            }

            throw Exception("Please handle all states above $state");
          },
        ),
      ],
    );
  }

  @override
  HistoryPeriodsCubit getPageBloc() => _cubit;

  Widget _buildHistoryPeriodsView(
      List<HistoryPeriod> items, TextDirection direction, bool isDarkMode) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(
          onTapUp: (d) {
            //TODO: select item
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                        child: Text(
                      "${item.displayName} (${item.id})",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(item.unitName),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
