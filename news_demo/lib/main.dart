import 'package:flutter/material.dart';
import 'package:news_demo/pages/newsListPage.dart';
import 'package:news_demo/viewmodels/newsArticleListViewModel.dart';
import 'package:provider/provider.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Fresh News",
        home: ChangeNotifierProvider(
            create: (_) => NewsArticleListViewModel(),
            child: const NewsListPage()));
  }
}
