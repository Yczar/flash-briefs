import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flash_briefs/app/data/models/news_article.dart';

class NewsAPIService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://newsapi.org/v2';
  final String _apiKey = 'ae2f941cb6bf40bb901d0d61919d82aa';

  Future<List<NewsArticle>> fetchTopHeadlines() async {
    try {
      final response = await _dio.get(
        '$_baseUrl/top-headlines',
        queryParameters: {
          'country': 'us',
          'apiKey': _apiKey,
        },
      );
      List<dynamic> articles = response.data['articles'];
      log('Articles $articles');
      return articles.map((article) => NewsArticle.fromJson(article)).toList();
    } catch (error) {
      print(error);
      throw Exception('Failed to load top headlines');
    }
  }
}
