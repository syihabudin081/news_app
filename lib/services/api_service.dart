import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:news_app/models/news_model.dart';

class NewsApiService {
  final String apiUrl =
      "http://newsapi.org/v2/top-headlines?country=us&apiKey=a350539d9a78406ea1f3da1e4137760b";

  Future<List<Article>> fetchArticles(String category) async {
    final response =
        await http.get(Uri.parse(apiUrl + "&category=" + category));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final articlesData = jsonData['articles'] as List<dynamic>;
      return articlesData
          .map((articleJson) => Article.fromJson(articleJson))
          .toList();
    } else {
      print('API Error: ${response.statusCode} - ${response.reasonPhrase}');
      print('Response Body: ${response.body}');
      throw Exception('Failed to load articles');
    }
  }
}
