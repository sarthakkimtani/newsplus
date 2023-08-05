import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../configs/custom_icons.dart";
import "../../providers/securities.dart";

class SecurityListTile extends StatefulWidget {
  final String name;
  final String ticker;
  final double price;
  final double dayChangePercent;
  final bool icon;

  const SecurityListTile(
      {Key? key,
      required this.name,
      required this.ticker,
      required this.price,
      required this.dayChangePercent,
      required this.icon})
      : super(key: key);

  @override
  State<SecurityListTile> createState() => _SecurityListTileState();
}

class _SecurityListTileState extends State<SecurityListTile> {
  bool _isSaved = false;

  @override
  void didChangeDependencies() {
    _isSaved = Provider.of<Securities>(context, listen: false)
        .containsSaved(widget.ticker);
    super.didChangeDependencies();
  }

  Future<void> _toggleSave(String ticker) async {
    if (_isSaved) {
      await Provider.of<Securities>(context, listen: false)
          .removeSavedSecurity(ticker);
      setState(() {
        _isSaved = false;
      });
    } else {
      await Provider.of<Securities>(context, listen: false)
          .saveSecurity(ticker);
      setState(() {
        _isSaved = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: widget.icon ? const EdgeInsets.only(left: 10) : null,
      dense: true,
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.black,
        child: Text(
          widget.name[0],
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      title: Text(
        widget.ticker,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context)
            .textTheme
            .displayMedium!
            .copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        widget.name,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: const Color(0xFFa0b0ba),
            ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.price.toStringAsFixed(2),
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              widget.dayChangePercent < 0
                  ? Text(
                      "${widget.dayChangePercent.toStringAsFixed(2)}%",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.error),
                    )
                  : Text(
                      "+${widget.dayChangePercent.toStringAsFixed(2)}%",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 14, color: Colors.green),
                    )
            ],
          ),
          widget.icon
              ? IconButton(
                  onPressed: () => _toggleSave(widget.ticker),
                  icon: Icon(
                    _isSaved
                        ? CustomIcons.bookmark
                        : CustomIcons.bookmark_empty,
                    size: 26,
                    color: Colors.black,
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
