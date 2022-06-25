import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket/logic/currency_pair/currency_pair_bloc.dart';
import 'package:websocket/logic/currency_pair/currency_pair_event.dart';
import 'package:websocket/logic/currency_pair/currentcy_pair_state.dart';

import '../../components/list_item_widget.dart';

class CurrencyListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CurrebcyListPage();
  }
}

class _CurrebcyListPage extends State<CurrencyListPage> {
  bool isInit = false;

  @override
  void didChangeDependencies() {
    if (!isInit) {
      isInit = true;
      BlocProvider.of<CurrencyPairBloc>(context).add(FetchCurrencyList());
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<CurrencyPairBloc, CurrencyPairState>(
      buildWhen: ((previous, current) =>
          current is LoadingState || current is CurrencyPairListUpdateState),
      builder: (context, state) {
        return state is LoadingState
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(children: [
                Expanded(
                    child: ListView.builder(
                        itemCount: state.list.length,
                        itemBuilder: (context, index) => Card(
                                child: ListItemWidget(
                              onTap: () {
                                BlocProvider.of<CurrencyPairBloc>(context)
                                    .add(OnCurrencySelected(state.list[index]));
                              },
                              item: state.list[index],
                            )))),
                InkWell(
                  onTap: () {
                    BlocProvider.of<CurrencyPairBloc>(context)
                        .add(CancelSubscription());
                  },
                  child: Container(
                    color: Colors.red[700],
                    width: double.infinity,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text(
                      "Cancel Subscription",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ]);
      },
    ));
  }

  @override
  void dispose() {
    BlocProvider.of<CurrencyPairBloc>(context).add(DisposeEvent());
    BlocProvider.of<CurrencyPairBloc>(context).close();
    super.dispose();
  }
}
