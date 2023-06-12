import "package:flutter/material.dart";

import "./securities_search.dart";

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 35, right: 35, bottom: 50),
      child: GestureDetector(
        onTap: () => showSearch(context: context, delegate: SecuritiesSearch()),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFa39b9b), width: 1.5),
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
          child: Text(
            "Search",
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
