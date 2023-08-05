import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../providers/securities.dart";
import "../../widgets/image_banner.dart";
import "../../widgets/shimmer/markets_shimmer.dart";
import "../../widgets/securities/securities_list.dart";

class MarketsScreen extends StatefulWidget {
  const MarketsScreen({Key? key}) : super(key: key);

  @override
  State<MarketsScreen> createState() => _MarketsScreenState();
}

class _MarketsScreenState extends State<MarketsScreen> {
  late Future<void> _securitiesFuture;

  @override
  void initState() {
    _securitiesFuture =
        Provider.of<Securities>(context, listen: false).fetchSecurities();
    super.initState();
  }

  Future<void> _refresh() async {
    await Provider.of<Securities>(context, listen: false).fetchSecurities();
  }

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<Securities>(context).items;

    return FutureBuilder(
      future: _securitiesFuture,
      builder: (ctx, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? const MarketsShimmer()
          : snapshot.hasError
              ? const ImageBanner(
                  imgSrc: "assets/images/error.png",
                  text: "Something Went Wrong!")
              : RefreshIndicator(
                  onRefresh: _refresh,
                  color: Theme.of(context).primaryColor,
                  child: SingleChildScrollView(
                    child: Container(
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: SecuritiesList(items),
                    ),
                  ),
                ),
    );
  }
}
