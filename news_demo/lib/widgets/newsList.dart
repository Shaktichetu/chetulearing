import 'package:flutter/material.dart';
import 'package:news_demo/viewmodels/newsArticleViewModel.dart';

class NewsList extends StatelessWidget {
  final List<NewsArticleViewModel>? articles;
  final Function(NewsArticleViewModel article)? onSelected;

  const NewsList({super.key, this.articles, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles!.length,
      itemBuilder: (context, index) {
        final article = articles![index];

        return ListTile(
          onTap: () {
            onSelected!(article);
          },
          leading: SizedBox(
              width: 100,
              height: 100,
              child: article.imageURL == null
                  ? Image.asset("images/news-placeholder.png")
                  : Image.network(article.imageURL!)),
          title: Text(article.title!),
        );
      },
    );
  }
}
