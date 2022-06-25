import 'package:websocket/models/currency_model.dart';

import '../../models/list_item_model.dart';

class CurrencyPairState {
  List<ListItemModel> list = [];

  CurrencyPairState(this.list);
}

class InitState extends CurrencyPairState {
  InitState(List<ListItemModel> list) : super(list);
}

class LoadingState extends CurrencyPairState {
  LoadingState(List<ListItemModel> list) : super(list);
}

class CurrencyPairListUpdateState extends CurrencyPairState {
  CurrencyPairListUpdateState(List<ListItemModel> list) : super(list);
}
