import 'package:flash_briefs/app/data/models/news_article.dart';
import 'package:flash_briefs/app/ui/widgets/article_card_widget.dart';
import 'package:flutter/material.dart';

class PostListsWidget extends StatelessWidget {
  const PostListsWidget({
    super.key,
    required this.articles,
  });
  final List<NewsArticle> articles;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: articles
            .map(
              (article) => ArticleCardWidget(
                article: article,
              ),
            )
            .toList(),
      ),
    );
  }
}
