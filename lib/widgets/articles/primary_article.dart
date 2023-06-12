// ignore_for_file: use_key_in_widget_constructors
import "package:flutter/material.dart";
import 'package:cached_network_image/cached_network_image.dart';

import './article_web_view.dart';
import '../../models/article.dart';

class PrimaryArticle extends StatelessWidget {
  final Article article;

  const PrimaryArticle(this.article);

  @override
  Widget build(BuildContext context) {
    final hours = DateTime.now().difference(article.publishedAt).inHours;
    final days = DateTime.now().difference(article.publishedAt).inDays;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ArticleWebView(article.id, article.url),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: CachedNetworkImage(
                    fadeOutDuration: const Duration(milliseconds: 100),
                    errorWidget: (ctx, url, error) => const Icon(Icons.error),
                    imageUrl: article.imageUrl,
                    fit: BoxFit.cover,
                  )),
            ),
            const SizedBox(height: 15),
            Text(
              article.title,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: 16),
            ),
            const SizedBox(height: 15),
            Text(
              hours < 24
                  ? "Published $hours hours ago"
                  : "Published $days days ago",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: const Color(0xFFa0b0ba),
                    fontSize: 12,
                  ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
