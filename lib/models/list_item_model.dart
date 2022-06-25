class ListItemModel {
  late String currencyId;
  late String quoteVolume;
  late String baseVolume;
  late bool isSubscriped;
  late bool isLoading;

  ListItemModel(
      {required this.currencyId,
      required this.baseVolume,
      required this.quoteVolume,
      required this.isSubscriped,
      required this.isLoading});
}
