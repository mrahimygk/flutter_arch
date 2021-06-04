class ExchangeRate {
  final String time;
  final String coinId;
  final double rate;

  ExchangeRate(
    this.time,
    this.coinId,
    this.rate,
  );

  ExchangeRate copyWith({
    String? time,
    String? coinId,
    double? rate,
  }) =>
      ExchangeRate(
        time ?? this.time,
        coinId ?? this.coinId,
        rate ?? this.rate,
      );
}
