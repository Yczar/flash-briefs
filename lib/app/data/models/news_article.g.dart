// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsArticle _$NewsArticleFromJson(Map<String, dynamic> json) => NewsArticle(
      title: json['title'] as String?,
      description: json['description'] as String?,
      url: json['url'] as String?,
      author: json['author'] as String?,
      urlToImage: json['urlToImage'] as String?,
      publishedAt: json['publishedAt'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$NewsArticleToJson(NewsArticle instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'author': instance.author,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt,
      'content': instance.content,
    };
