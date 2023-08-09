import 'package:flutter/material.dart';
import 'package:news_demo/viewmodels/newsArticleViewModel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsArticleDetailsPage extends StatelessWidget {
  final NewsArticleViewModel? article;

  const NewsArticleDetailsPage({super.key, this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article!.title!)),
      body: const Center(
        child: Text("Hello shakti"),
      ),
      // body: WebView(
      //   initialUrl: this.article.url,
      // )
    );
  }
}
