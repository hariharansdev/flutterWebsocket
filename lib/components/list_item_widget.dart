import 'package:flutter/material.dart';
import 'package:websocket/models/list_item_model.dart';

class ListItemWidget extends StatelessWidget {
  ListItemModel item;
  Function onTap;
  ListItemWidget({Key? key, required this.item, required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Column(children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(item.currencyId),
            Offstage(
                offstage: !item.isLoading,
                child: const SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                )),
            Offstage(
                offstage: item.isLoading,
                child: SizedBox(
                  height: 50,
                  width: 100,
                  child: Text(
                    item.isSubscriped ? "Subscribed" : "Subscribe",
                    style: TextStyle(
                        color: item.isSubscriped ? Colors.green : Colors.grey),
                  ),
                )),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Text(item.baseVolume), Text(item.quoteVolume)],
        )
      ]),
    );
  }
}
