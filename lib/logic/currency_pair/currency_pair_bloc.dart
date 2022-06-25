import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:websocket/logic/currency_pair/currency_pair_event.dart';
import 'package:websocket/logic/currency_pair/currentcy_pair_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket/models/list_item_model.dart';
import '../../http/api_constant.dart';
import '../../models/currency_model.dart';
import '../../models/update_currency_model.dart';

class CurrencyPairBloc extends Bloc<CurrencyPairEvent, CurrencyPairState> {
  List<ListItemModel> list = [];
  late final WebSocketChannel _ethWebsocket;
  CurrencyPairBloc() : super(InitState([])) {
    _initEvent();
    on<OnCurrencySelected>(_onSelected);
    on<FetchCurrencyList>(_fetchData);
    on<OnItemUpdate>(_onItemUpdate);
    on<CancelSubscription>(_cancelSubs);
    on<DisposeEvent>(_disposeEvent);
  }

  Future<FutureOr<void>> _onSelected(
      OnCurrencySelected event, Emitter<CurrencyPairState> emit) async {
    event.selectedItem.isLoading = true;
    event.selectedItem.isSubscriped = true;
    for (var element in list) {
      if (element.currencyId == event.selectedItem.currencyId) {
        element = event.selectedItem;
      }
    }
    _ethWebsocket.sink.add(jsonEncode({
      "id": 12312,
      "method": "ticker.subscribe",
      "params": [event.selectedItem.currencyId]
    }));
    emit(CurrencyPairListUpdateState(list));
  }

  Future<FutureOr<void>> _fetchData(
      FetchCurrencyList event, Emitter<CurrencyPairState> emit) async {
    emit(LoadingState([]));
    String url = ApiConstant.baseUrl + ApiConstant.currencyPairs;
    Response response = await Dio().get(url);
    List<String> needSkipList = [
      "BTC_USDT",
      "ETH_USDT",
      "LTC_USDT",
      "ETH_BTC",
      "LTC_BTC",
      "GRT_USDT",
      "KDA_USDT",
      "MATIC_USDT",
      "CELL_USDT",
      "AAVE_USDT",
      "MANA_USDT",
      "MANA_ETH",
      "DASH_BTC",
      "DASH_USDT"
    ];
    await Future.delayed(const Duration(seconds: 3));
    if (response.data != null) {
      var cList = (response.data as List)
          .map<CurrencyModel>((v) => CurrencyModel.fromJson(v))
          .toList();
      List<ListItemModel> listv = [];
      for (var element in needSkipList) {
        for (var cItem in cList) {
          if (cItem.id == element) {
            ListItemModel itemModel = ListItemModel(
                currencyId: cItem.id,
                baseVolume: "0",
                quoteVolume: "0",
                isSubscriped: false,
                isLoading: false);
            listv.add(itemModel);
          }
        }
      }

      list = listv;
      emit(CurrencyPairListUpdateState(listv));
    }
  }

  FutureOr<void> _initEvent() {
    _ethWebsocket = WebSocketChannel.connect(
      Uri.parse(ApiConstant.webSocketUrl),
    );
    _ethWebsocket.stream.listen((event) {
      if ((jsonDecode(event.toString()) as Map).containsKey("params")) {
        UpdateCurrencyModel data = UpdateCurrencyModel.fromJson(
            (jsonDecode(event.toString()) as Map)['params'][1]);

        String id = (jsonDecode(event.toString()) as Map)['params'][0];
        for (var element in list) {
          if (element.currencyId == id) {
            element.baseVolume = data.baseVolume;
            element.quoteVolume = data.quoteVolume;
            element.isLoading = false;
          }
        }

        add(OnItemUpdate());
        // emit(CurrencyPairListUpdateState(list));
      }
    });
  }

  FutureOr<void> _onItemUpdate(
      OnItemUpdate event, Emitter<CurrencyPairState> emit) {
    emit(CurrencyPairListUpdateState(list));
  }

  FutureOr<void> _cancelSubs(
      CancelSubscription event, Emitter<CurrencyPairState> emit) {
    _ethWebsocket.sink.add(jsonEncode(
        {"id": 12312, "method": "ticker.unsubscribe", "params": []}));
    for (var element in list) {
      element.isLoading = false;
      element.isSubscriped = false;
    }
    emit(CurrencyPairListUpdateState(list));
  }

  FutureOr<void> _disposeEvent(
      DisposeEvent event, Emitter<CurrencyPairState> emit) {
    _ethWebsocket.sink.close();
  }
}
