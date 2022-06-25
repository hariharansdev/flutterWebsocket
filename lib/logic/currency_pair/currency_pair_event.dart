import 'package:websocket/models/currency_model.dart';
import 'package:websocket/models/list_item_model.dart';

class CurrencyPairEvent {}

class OnCurrencySelected extends CurrencyPairEvent {
  ListItemModel selectedItem;

  OnCurrencySelected(this.selectedItem);
}

class FetchCurrencyList extends CurrencyPairEvent {}

class InitEvent extends CurrencyPairEvent {}

class DisposeEvent extends CurrencyPairEvent {}

class CancelSubscription extends CurrencyPairEvent {}

class OnItemUpdate extends CurrencyPairEvent {}
