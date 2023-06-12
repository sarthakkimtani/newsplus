// ignore_for_file: use_key_in_widget_constructors
import "package:flutter/material.dart";

import "../../models/security.dart";
import "./securities_list_tile.dart";

class SecuritiesList extends StatelessWidget {
  final List<Security> securitiesData;

  const SecuritiesList(this.securitiesData);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            "Trending Securities",
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        const SizedBox(height: 15),
        ListView.separated(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (ctx, i) => SecurityListTile(
            name: securitiesData[i].name,
            ticker: securitiesData[i].ticker,
            price: securitiesData[i].price,
            dayChangePercent: securitiesData[i].dayChangePercent,
            icon: true,
          ),
          separatorBuilder: (ctx, i) => const Divider(
            color: Color(0xFFa0b0ba),
          ),
          itemCount: securitiesData.length,
        )
      ],
    );
  }
}
