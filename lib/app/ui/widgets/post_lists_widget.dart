import 'package:flash_briefs/app/data/models/news_article.dart';
import 'package:flash_briefs/app/ui/cubits/top_headlines/top_headlines_cubit.dart';
import 'package:flash_briefs/app/ui/widgets/article_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostListsWidget extends StatelessWidget {
  const PostListsWidget({
    super.key,
    required this.articles,
  });
  final List<NewsArticle> articles;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.blue,
      onRefresh: () async {
        context.read<TopHeadlinesCubit>().fetchTopHeadlines();
      },
      child: SingleChildScrollView(
        child: Column(
          children: articles
              .map(
                (article) => ArticleCardWidget(
                  article: article,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
