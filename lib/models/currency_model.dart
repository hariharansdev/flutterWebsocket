class CurrencyModel {
  late String id;
  late String base;
  late String quote;
  late String fee;
  late String minQuoteAmount;
  late int amountPrecision;
  late int precision;
  late String tradeStatus;
  late int sellStart;
  late int buyStart;

  CurrencyModel(
      this.id,
      this.base,
      this.quote,
      this.fee,
      this.minQuoteAmount,
      this.amountPrecision,
      this.precision,
      this.tradeStatus,
      this.sellStart,
      this.buyStart);

  CurrencyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    base = json['base'] ?? "";
    quote = json['quote'] ?? "";
    fee = json['fee'] ?? "";
    minQuoteAmount = json['min_quote_amount'] ?? "";
    amountPrecision = json['amount_precision'];
    precision = json['precision'];
    tradeStatus = json['trade_status'] ?? "";
    sellStart = json['sell_start'];
    buyStart = json['buy_start'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['base'] = base;
    data['quote'] = quote;
    data['fee'] = fee;
    data['min_quote_amount'] = minQuoteAmount;
    data['amount_precision'] = amountPrecision;
    data['precision'] = precision;
    data['trade_status'] = tradeStatus;
    data['sell_start'] = sellStart;
    data['buy_start'] = buyStart;
    return data;
  }
}
