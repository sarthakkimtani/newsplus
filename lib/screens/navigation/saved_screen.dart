// ignore_for_file: use_key_in_widget_constructors
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../../providers/articles.dart';
import '../../models/article.dart';
import '../../widgets/articles/secondary_article.dart';
import '../../widgets/image_banner.dart';

class SavedScreen extends StatefulWidget {
  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  late Future<void> _articleFuture;
  
  @override
  void initState() {
    _articleFuture =
        Provider.of<Articles>(context, listen: false).fetchSavedArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Article> items = Provider.of<Articles>(context).savedItems;
    return FutureBuilder(
      future: _articleFuture,
      builder: (ctx, snapshot) {
        if (items.isEmpty) {
          return const ImageBanner(
            imgSrc: "assets/images/empty.png",
            text: "No Saved Articles!",
          );
        }
        return Container(
          margin: const EdgeInsets.only(left: 25, right: 25, top: 10),
          child: ListView.separated(
            itemBuilder: (ctx, i) => SecondaryArticle(items[i]),
            separatorBuilder: (_, i) => const Divider(color: Color(0xFFa0b0ba)),
            itemCount: items.length,
          ),
        );
      },
    );
  }
}
