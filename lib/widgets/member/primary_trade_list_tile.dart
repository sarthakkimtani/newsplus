import "package:flutter/material.dart";
import "package:intl/intl.dart";

import "../../models/trade_notification.dart";

class PrimaryTradeListTile extends StatelessWidget {
  final TradeNotification trade;

  const PrimaryTradeListTile(this.trade, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(16),
          color: trade.position == "LONG" ? Colors.green : Colors.red,
          child: Column(
            children: [
              _Header(trade: trade),
              const SizedBox(height: 20),
              _TradeDetails(trade: trade),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final TradeNotification trade;

  const _Header({required this.trade});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          trade.ticker,
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5.0,
                spreadRadius: 1.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Text(
                trade.position,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Icon(
                trade.position == "LONG"
                    ? Icons.arrow_upward_rounded
                    : Icons.arrow_downward_rounded,
                size: 30,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class _TradeDetails extends StatelessWidget {
  final TradeNotification trade;

  _TradeDetails({required this.trade});

  var f = NumberFormat("###,###.0####", "en_US");

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _TradeDetailColumn(
          label: "ENTRY",
          value: f.format(trade.entryPrice),
        ),
        _TradeDetailColumn(
          label: "STOP LOSS",
          value: f.format(trade.stopLoss),
        ),
        _TradeDetailColumn(
          label: "TAKE PROFIT",
          value: f.format(trade.takeProfit),
        ),
      ],
    );
  }
}

class _TradeDetailColumn extends StatelessWidget {
  final String label;
  final String value;

  const _TradeDetailColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white)),
        Text(value),
      ],
    );
  }
}
