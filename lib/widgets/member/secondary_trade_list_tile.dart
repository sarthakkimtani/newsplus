import "package:flutter/material.dart";
import "package:intl/intl.dart";

import "../../models/trade_notification.dart";

// ignore: must_be_immutable
class SecondaryTradeListTile extends StatelessWidget {
  final TradeNotification trade;

  SecondaryTradeListTile(
    this.trade, {
    Key? key,
  }) : super(key: key);

  var f = NumberFormat("###,###.0####", "en_US");

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        alignment: Alignment.centerLeft,
        width: MediaQuery.of(context).size.width * 0.25,
        child: Text(
          trade.position,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: trade.position == "LONG" ? Colors.green : Colors.red,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      title: Text(
        trade.ticker,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
      ),
      trailing: Container(
        alignment: Alignment.centerRight,
        width: MediaQuery.of(context).size.width * 0.25,
        child: Text(
          f.format(trade.entryPrice),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}
