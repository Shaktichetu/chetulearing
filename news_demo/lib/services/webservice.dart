import 'dart:convert';

import 'package:news_demo/models/newsArticle.dart';
import 'package:news_demo/utils/constants.dart';
import 'package:http/http.dart' as http;

class Webservice {
  

  Future<List<NewsArticle>> fetchHeadlinesByKeyword(String keyword) async {

    final response = await http.get(Uri.parse(Constants.headlinesFor(keyword)) );

    if(response.statusCode == 200) {
      final result = jsonDecode(response.body); 
      Iterable list = result["articles"];
      return list.map((json) => NewsArticle.fromJSON(json)).toList();
    } else {
      throw Exception("Failed to get news");
    }


  }



  Future<List<NewsArticle>> fetchTopHeadlines() async {
    
    final response = await http.get(Uri.parse(Constants.TOP_HEADLINES_URL));

    if(response.statusCode == 200) {

      final result = jsonDecode(response.body);
      Iterable list = result["articles"];
      return list.map((article) => NewsArticle.fromJSON(article)).toList();

    } else {
      throw Exception("Failed to get top news");
    }

  }
}
