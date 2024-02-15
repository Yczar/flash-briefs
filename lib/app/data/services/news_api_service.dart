import 'package:dio/dio.dart';
import 'package:flash_briefs/app/data/models/news_article.dart';

/// A service class for fetching news articles using the NewsAPI.
///
/// This class provides functionality to retrieve the top headlines
/// from the NewsAPI and convert them into a list of [NewsArticle] objects.
class NewsAPIService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://newsapi.org/v2';

  /// The API key for accessing NewsAPI, retrieved from environment variables.
  final String _apiKey = const String.fromEnvironment('newsAPIKey');

  /// Fetches the top headlines from the United States.
  ///
  /// This method sends a GET request to the NewsAPI top-headlines endpoint,
  /// requesting articles for the 'us' country code. It parses the JSON response
  /// into a list of [NewsArticle] instances.
  ///
  /// Returns a list of [NewsArticle] objects representing the top headlines.
  ///
  /// Throws an [Exception] if there is any error during the HTTP request or
  /// if the response is not in the expected format.
  Future<List<NewsArticle>> fetchTopHeadlines() async {
    try {
      final response = await _dio.get(
        '$_baseUrl/top-headlines',
        queryParameters: {
          'country': 'us',
          'apiKey': _apiKey,
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> articles = response.data['articles'];

        return articles
            .map((article) => NewsArticle.fromJson(article))
            .toList();
      } else {
        // Handle non-200 responses
        throw Exception(
          'Failed to load top headlines: Server responded with ${response.statusCode}',
        );
      }
    } on DioException catch (dioException) {
      // Handle Dio-specific errors with more detailed message
      throw Exception('Failed to load top headlines: ${dioException.message}');
    } catch (error) {
      // Handle any other errors
      throw Exception('Failed to load top headlines');
    }
  }
}
