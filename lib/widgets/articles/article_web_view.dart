import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import "package:url_launcher/url_launcher.dart" as launcher;
import "package:webview_flutter/webview_flutter.dart";

import '../../configs/custom_icons.dart';
import '../../providers/articles.dart';

class ArticleWebView extends StatefulWidget {
  final String id;
  final String articleUrl;

  const ArticleWebView(this.id, this.articleUrl, {Key? key}) : super(key: key);

  @override
  State<ArticleWebView> createState() => _ArticleWebViewState();
}

class _ArticleWebViewState extends State<ArticleWebView> {
  late bool _isSaved;

  @override
  void initState() {
    _isSaved =
        Provider.of<Articles>(context, listen: false).containsSaved(widget.id);
    super.initState();
  }

  Future<void> _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await launcher.canLaunchUrl(uri)) {
      await launcher.launchUrl(uri,
          mode: launcher.LaunchMode.externalApplication);
    } else {
      return;
    }
  }

  Future<void> _toggleSave(String id) async {
    if (_isSaved) {
      await Provider.of<Articles>(context, listen: false)
          .removeSavedArticle(id);
      setState(() {
        _isSaved = false;
      });
    } else {
      await Provider.of<Articles>(context, listen: false).saveArticle(id);
      setState(() {
        _isSaved = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.white),
        ),
      ),
      body: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(widget.articleUrl)),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        child: SizedBox(
          height: 45,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 14,
                        ),
                    minimumSize: const Size(100, 30),
                    side: const BorderSide(
                      color: Colors.white,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () => _launchURL(widget.articleUrl),
                  child: const Text("Open in Browser"),
                ),
                IconButton(
                  onPressed: () => _toggleSave(widget.id),
                  color: Colors.white,
                  icon: Icon(
                    _isSaved
                        ? CustomIcons.bookmark
                        : CustomIcons.bookmark_empty,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
