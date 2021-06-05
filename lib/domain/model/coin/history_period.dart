class HistoryPeriod {
  final String id;
  final int lengthBySeconds;
  final int lengthByMonths;
  final int unitCount;
  final String unitName;
  final String displayName;

  HistoryPeriod(
    this.id,
    this.lengthBySeconds,
    this.lengthByMonths,
    this.unitCount,
    this.unitName,
    this.displayName,
  );
}
