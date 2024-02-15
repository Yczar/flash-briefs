import 'package:json_annotation/json_annotation.dart';

part 'news_article.g.dart';

@JsonSerializable()
class NewsArticle {
  final String? title;
  final String? description;
  final String? url;
  final String? author;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  NewsArticle({
    required this.title,
    required this.description,
    required this.url,
    required this.author,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) =>
      _$NewsArticleFromJson(json);
  Map<String, dynamic> toJson() => _$NewsArticleToJson(this);
}
