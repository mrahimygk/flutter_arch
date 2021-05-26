class Coin {
  final String id;
  final int symbolsCount;
  final String name;
  final String website;
  final double hourlyVolume;
  final double dailyVolume;
  final double monthlyVolume;
  final String? url;

  Coin(
    this.id,
    this.symbolsCount,
    this.name,
    this.website,
    this.hourlyVolume,
    this.dailyVolume,
    this.monthlyVolume,
    this.url,
  );

  Coin copyWith({
    String? id,
    int? symbolsCount,
    String? name,
    String? website,
    double? hourlyVolume,
    double? dailyVolume,
    double? monthlyVolume,
    String? url,
  }) =>
      Coin(
        id ?? this.id,
        symbolsCount ?? this.symbolsCount,
        name ?? this.name,
        website ?? this.website,
        hourlyVolume ?? this.hourlyVolume,
        dailyVolume ?? this.dailyVolume,
        monthlyVolume ?? this.monthlyVolume,
        url ?? this.url,
      );
}
