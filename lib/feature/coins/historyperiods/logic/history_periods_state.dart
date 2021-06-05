part of 'history_periods_cubit.dart';

abstract class HistoryPeriodsState extends PageState {
  const HistoryPeriodsState();
}

class HistoryPeriodsInitialState extends HistoryPeriodsState {
  @override
  List<Object?> get props => [];
}

class HistoryPeriodsLoadingState extends HistoryPeriodsState {
  @override
  List<Object?> get props => [];
}

class HistoryPeriodsNoDataState extends HistoryPeriodsState {
  @override
  List<Object?> get props => [];
}

class HistoryPeriodsErrorState extends HistoryPeriodsState {
  final String error;

  HistoryPeriodsErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class HistoryPeriodsDataReceivedState extends HistoryPeriodsState {
  final List<HistoryPeriod> periods;

  HistoryPeriodsDataReceivedState(this.periods);

  @override
  List<Object?> get props => [periods];
}
