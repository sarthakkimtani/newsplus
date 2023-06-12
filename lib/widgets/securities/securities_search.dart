import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../models/security.dart";
import "../../providers/securities.dart";

class SecuritiesSearch extends SearchDelegate {
  late List<Security> items;

  List<Security> getSearchResults(List<Security> items) {
    List<Security> matchResults = [];
    for (var security in items) {
      if (security.name.toLowerCase().contains(query.toLowerCase()) ||
          security.ticker.toLowerCase().contains(query.toLowerCase())) {
        matchResults.add(security);
      }
    }

    return matchResults;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    items = Provider.of<Securities>(context).savedItems;
    List<Security> results = getSearchResults(items);

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: ((context, i) => ListTile(
            title: Text(results[i].ticker),
            subtitle: Text(results[i].name),
          )),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    items = Provider.of<Securities>(context).savedItems;
    List<Security> results = getSearchResults(items);

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: ((context, i) => ListTile(
            title: Text(results[i].ticker),
            subtitle: Text(results[i].name),
          )),
    );
  }
}