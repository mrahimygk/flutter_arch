class RateHistoryRequest {
  final String baseId;
  final String quoteId;

  final String periodId;
  final String? startTime;
  final String? endTime;

  RateHistoryRequest(
    this.baseId,
    this.quoteId,
    this.periodId,
    this.startTime,
    this.endTime,
  );
}
