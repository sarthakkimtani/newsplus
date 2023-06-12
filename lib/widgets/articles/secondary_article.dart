// ignore_for_file: use_key_in_widget_constructors
import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";

import "./article_web_view.dart";
import '../../models/article.dart';

class SecondaryArticle extends StatelessWidget {
  final Article article;

  const SecondaryArticle(this.article);

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 220,
                  height: 80,
                  child: Column(
                    children: [
                      Flexible(
                        child: Text(
                          article.title,
                          overflow: TextOverflow.fade,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
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
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 90,
                height: 90,
                child: CachedNetworkImage(
                  fadeInDuration: const Duration(milliseconds: 100),
                  errorWidget: (ctx, url, error) => const Icon(Icons.error),
                  imageUrl: article.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
