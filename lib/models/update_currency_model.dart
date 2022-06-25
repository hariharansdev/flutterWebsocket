class UpdateCurrencyModel {
  late int period;
  late String open;
  late String close;
  late String high;
  late String low;
  late String last;
  late String change;
  late String quoteVolume;
  late String baseVolume;

  UpdateCurrencyModel(this.period, this.open, this.close, this.high, this.low,
      this.last, this.change, this.quoteVolume, this.baseVolume);

  UpdateCurrencyModel.fromJson(Map<String, dynamic> json) {
    period = json['period'] ?? 0;
    open = json['open'] ?? "";
    close = json['close'] ?? "";
    high = json['high'] ?? "";
    low = json['low'] ?? "";
    last = json['last'] ?? "";
    change = json['change'] ?? "";
    quoteVolume = json['quoteVolume'] ?? "";
    baseVolume = json['baseVolume'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['period'] = period;
    data['open'] = open;
    data['close'] = close;
    data['high'] = high;
    data['low'] = low;
    data['last'] = last;
    data['change'] = change;
    data['quoteVolume'] = quoteVolume;
    data['baseVolume'] = baseVolume;
    return data;
  }
}
