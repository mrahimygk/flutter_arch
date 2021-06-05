class RateHistory {
  final String startingDate;
  final String endingDate;
  final String openTime;
  final String closeTime;

  final double openRate;
  final double highRate;
  final double lowRate;
  final double closeRate;

  RateHistory(
    this.startingDate,
    this.endingDate,
    this.openTime,
    this.closeTime,
    this.openRate,
    this.highRate,
    this.lowRate,
    this.closeRate,
  );
}
